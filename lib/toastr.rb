# require 'aasm'
require 'toastr/has_toast'

module Toastr

  # class Toast < ActiveRecord::Base
  #   self.table_name = :toastr_toasts
  #   belongs_to :parent, polymorphic: true
  #   serialize :blob_json

  #   include AASM
  #   aasm column: :status do
  #     state :empty, initial: true
  #     state :queued 
  #     state :cached

  #     event :queue do
  #       after do
  #         pare
  #         self.delay.refresh!
  #       end

  #       transitions from: [:empty, :cached], to: :queued
  #     end

  #     event :complete do
  #       transitions from: :queued, to: :cached
  #       after do

  #       end
  #     end

  #   end

  #   def stale?
  #     self.empty? || self.cache_json.present? && self.cached_at < self.expires.ago
  #   end

  #   def as_json
  #     case cache_state.to_sym

  #     when :cached
  #       queue_if_stale
  #       cache_json

  #     when :empty
  #       queue_if_stale #delay.build!
  #       try(:empty_cache_json) || { error: 'Data not yet available' }
      
  #     when :queued
  #       cache_json.present? ? cache_json : (try(:empty_cache_json) || { error: 'Data not yet available' })
  #     end
  #   end

  #   def queue_if_stale
  #     return unless self.stale?
  #     self.queue!
  #   end

  #   def refresh!
  #     result = nil
  #     elapsed = Benchmark.realtime { result = self.build! }
  #     self.cached_at = Time.now
  #     self.cache_json = result.merge({toastr: { elapsed: elapsed, cached_at: self.cached_at }})
  #     self.complete!
  #   end 
  # end

  # class Report < ActiveRecord::Base
  #   def data
  #     raise 'Abstract method not defined'
  #   end
  #   has_toast :data
  # end

end

# class ActiveRecord::Base
#   include Toastr::HasToast
# end
