require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "belongs to a user" do
    p = Post.new
    assert_respond_to p, :user
  end
end
