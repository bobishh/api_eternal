require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has one api key" do
    u = User.first
    assert_respond_to u, :api_key
  end

  test "has_many posts" do
    u = User.first
    assert_respond_to u, :posts
  end
end
