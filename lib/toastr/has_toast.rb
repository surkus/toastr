module Toastr
  module HasToast
    extend ActiveSupport::Concern

    module ClassMethods
      def has_toast(category, options = {})
        has_many :toasts, class_name: Toastr::Toast, as: :parent, dependent: :destroy

        begin
          alias_method "#{category}_for_toastr", category
        rescue
          raise ArgumentError.new "#{category} must be a defined instance method"
        end

        define_method category do
          raise 'Gotta persist activerecord first' unless self.persisted?
          toast = self.toasts.where(category: category).first_or_create

          case toast.status.to_sym
          when :cached
            Toastr.queue_if_stale!(self, toast, options)
            toast.cache_json
          when :empty
            toast.queue!
            options[:empty_cache_json] || { error: 'Data not yet available' }
          when :queued
            toast.cache_json.present? ? toast.cache_json : (options[:empty_cache_json] || { error: 'Data not yet available' })
          end
        end

      end # has_toast

    end # ClassMethods

  end
end

ActiveRecord::Base.send :include, Toastr::HasToast
