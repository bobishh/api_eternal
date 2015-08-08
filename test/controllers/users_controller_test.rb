require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @token = api_keys(:one).token
    @request.headers["HTTP_AUTHORIZATION"] = "Token token=#@token"
  end

  #unauthenticated
  test "requests authorization" do
    @request.headers["HTTP_AUTHORIZATION"] = nil 
    get :index
    assert_response 401
  end

  #authenticated
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "test@test.test", name: "BOB", password: "super" }
    end

    assert_response 201
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: {  name: "NOT BOB" }
    assert_response 204
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response 204
  end
end
