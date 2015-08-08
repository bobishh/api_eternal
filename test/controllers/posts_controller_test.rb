require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    @token = api_keys(:one).token
    @http_auth_header = { "HTTP_AUTHORIZATION" => "Token token=#@token" }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end


  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  #unauthenticated
  test "should not create post when unauth" do
    post :create, post: { content: @post.content, user_id: @post.user_id }
    assert_response 401
  end
  test "should not update post when unauth" do
    put :update, id: @post, post: { content: @post.content, user_id: @post.user_id }
    assert_response 401
  end
  test "should not destroy post when unauth" do
    delete :destroy, id: @post.id
    assert_response 401
  end

  #authenticated
  test "should create post when authenticated" do
    assert_difference('Post.count') do
      @request.headers["HTTP_AUTHORIZATION"] = "Token token=#@token"
      post_params = { post: { content: @post.content, user_id: @post.user_id } }
      post :create, post_params
    end

    assert_response 201
  end

  test "should update post when authenticated" do
    put_params = { id: @post, post: { content: @post.content, user_id: @post.user_id } }
    @request.headers["HTTP_AUTHORIZATION"] = "Token token=#@token"
    put :update, put_params
    assert_response 204
  end

  test "should destroy post when authenticated" do
    assert_difference('Post.count', -1) do
      @request.headers["HTTP_AUTHORIZATION"] = "Token token=#@token"
      delete :destroy, { id: @post.id }
    end

    assert_response 204
  end
end
