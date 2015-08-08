require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @password = 'superpass'
  end

  test "should update/create token if user presents" do
    post :create, { session: { email: @user.email, password: @password } }
    assert_response 200
  end

end
