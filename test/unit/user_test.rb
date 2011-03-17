require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "plans" do
    @user = Factory(:user)
    assert @user.free?
    @user.plan = "premium free"
    assert_false @user.free?
    assert @user.premium?
    @user.plan = "premium"
    assert @user.premium?
    assert_false @user.premium_plus?
    @user.plan = "premium plus"
    assert @user.premium?
    assert @user.premium_plus?
  end

end
