class Report < ActiveRecord::Base
  augment Toastr::Cachable

  serialize :key, Hash

  class << self
    def fetch(opts = {})
      where(key: opts.to_json).first_or_create()
    end
  end

  def build!
    raise NotImplementedError, 'Report is an abstract class.  You must implement a custom build!() method in subclasses.'
  end

  def expires
    1.hour
  end
end