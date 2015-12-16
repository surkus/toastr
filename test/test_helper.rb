# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class ActiveSupport::TestCase
  def count_queries &block
    count = 0

    counter_f = ->(name, started, finished, unique_id, payload) {
      unless payload[:name].in? %w[ CACHE SCHEMA ]
        count += 1
      end
    }
    ActiveSupport::Notifications.subscribed(counter_f, "sql.active_record", &block)
    count
  end
end