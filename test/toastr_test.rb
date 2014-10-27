require 'test_helper'

class ToastrTest < ActiveSupport::TestCase
  test "Plugin registered as a module" do
    assert_kind_of Module, Toastr
  end


end
