module Toastr
  module HasToast

    extend ActiveSupport::Concern

    included do

    end

    module ClassMethods
      def has_toast(category, options = {})
        puts 'successfully added toast'
      # begin
      #   alias_method "#{category}_for_toastr", category
      # rescue
      #   raise "must define #{category} to be toasted"
      # end

  #     Object.const_set("#{self.class.name}#{category.capitalize}ToastrActiveJob", Class.new do
  #       def perform(*args)
  #         toast.blob_json = self.send("#{category}_for_toastr")
  #       end
  #     end
  #     )

  #     define_method category do
  #       raise 'Gotta persist' unless self.persisted?
  #       toast = ::Toastr::Toast.find_by parent: self, category: category
  #       if toast.present?
  #         toast.as_json
  # # trigger logic. compare self.updated_at to toast.updated_at
  # # if :expires option
  #   # compare Time.now to toast.updated_at + param value
  # # if :expire_if
  #   # yield somewhere
  #       else
  #         new_toast = ::Toastr::Toast.create!(parent: self, category: category)
  # # empty toast message
  #       end
  #     end

      end
    end
  end
end