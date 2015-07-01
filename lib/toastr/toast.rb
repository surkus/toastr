require 'aasm'

module Toastr
  class Toast < ActiveRecord::Base
    self.table_name = :toastr_toasts
    belongs_to :parent, polymorphic: true

    serialize :cache_json

    include AASM

    aasm column: :status do
      state :empty, initial: true
      state :queued
      state :cached

      event :queue do
        after do
          self.refresh!
        end

        transitions from: [:empty, :cached], to: :queued
      end

      event :complete do
        transitions from: :queued, to: :cached
      end
    end

    def refresh!
      ::Toastr::Job.perform_later self
    end

  end
end
