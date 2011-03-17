require 'test_helper'
require 'webrat'

class HomesTest < ActionController::IntegrationTest

  test "test home page" do
    visit root_path
  end
  
end