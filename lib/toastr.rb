require 'augmentation'
require 'aasm'
require 'delayed_job'
require 'delayed_job_active_record'


module Toastr::Cachable

  augmentation do

    serialize :cache_json, Hash

    include AASM

    aasm column: :cache_state do

      state :empty, initial: true
      state :queued 
      state :cached

      event :queue do
        after do
          self.delay.refresh!
        end

        transitions from: [:empty, :cached], to: :queued
      end


      event :complete do
        transitions from: :queued, to: :cached
        after do

        end
      end

    end

    def stale?
      self.empty? || self.cache_json.present? && self.cached_at < self.expires.ago
    end

    def as_json
      case cache_state.to_sym

      when :cached
        queue_if_stale
        cache_json

      when :empty
        queue_if_stale #delay.build!
        try(:empty_cache_json) || { error: 'Data not yet available' }
      
      when :queued
        cache_json.present? ? cache_json : (try(:empty_cache_json) || { error: 'Data not yet available' })
      end
    end

    def queue_if_stale
      return unless self.stale?
      self.queue!
    end

    def refresh!
      result = nil
      elapsed = Benchmark.realtime { result = self.build! }
      self.cache_json = result.merge({toastr: { elapsed: elapsed }})
      self.cached_at = Time.now
      self.complete!
    end 

  end # / augmentation

end


