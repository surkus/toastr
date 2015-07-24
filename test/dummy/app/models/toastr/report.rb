module Toastr
  class Report < ActiveRecord::Base
    self.table_name = :toastr_reports

    serialize :key

    def build!
      raise 'Not implemented'
      # Implement expensive queries here, or in STI subclass.
      #
      # return {hash_of: :values}
    end

    # Cache will expire according default Toastr behavior. This may also be
    # overridden here or in STI subclass.
    has_toast :build!

  end
end