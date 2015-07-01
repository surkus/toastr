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
    # Remember to add
    #   has_toast :build!
    # to your STI sub class below the definition of #build!

  end
end