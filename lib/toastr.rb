require 'toastr/toast'
require 'toastr/job'
require 'toastr/has_toast'

module Toastr
  def self.queue_if_stale!(parent, toast, options)
    need_to_queue = if options[:expire_in].present?
      toast.updated_at < options[:expire_in].ago
    elsif options[:expire_if].present?
      options[:expire_if].yield(toast)
    else
      parent.updated_at > toast.updated_at
    end

    toast.queue! if need_to_queue
  end
end
