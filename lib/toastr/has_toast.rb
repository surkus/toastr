module Toastr
  module HasToast
    extend ActiveSupport::Concern

    module ClassMethods
      HAS_TOAST_OPTIONS_WHITELIST = [:empty_cache_json, :expire_in, :expire_if]
      def has_toast(category, options = {})
        has_many :toasts, class_name: Toastr::Toast, as: :parent, dependent: :destroy

        if (unrecognized_options = options.symbolize_keys!.keys - HAS_TOAST_OPTIONS_WHITELIST).any?
          raise ArgumentError.new "Unrecognized option(s): #{unrecognized_options.collect{|o| ':' + o.to_s}.join(', ')}. Allowed options are #{HAS_TOAST_OPTIONS_WHITELIST.collect{|o| ':' + o.to_s}.join(', ')}"
        end

        begin
          alias_method "#{category}_for_toastr", category
        rescue
          raise ArgumentError.new ":#{category} must be an already-defined instance method"
        end

        define_method category do
          raise "Record must be persisted in database before calling method :#{category}" unless self.persisted?
          toast = self.toasts.where(category: category).first_or_create

          case toast.status.to_sym
          when :cached
            Toastr.queue_if_stale!(self, toast, options.slice(:expire_in, :expire_if))
            toast.cache_json
          when :empty
            toast.queue!
            toast.reload if Rails.application.config.active_job.queue_adapter == :inline
            toast.cache_json || options[:empty_cache_json] || { error: 'Data not yet available' }
          when :queued
            toast.cache_json.present? ? toast.cache_json : (options[:empty_cache_json] || { error: 'Data not yet available' })
          end
        end

      end # has_toast

    end # ClassMethods

  end
end

ActiveRecord::Base.send :include, Toastr::HasToast
