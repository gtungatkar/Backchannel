require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures "posts"
  fixtures "users"
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    session[:user_id] = 10
    get :new
    assert_response :success
    
    session[:user_id] = nil
    get :new
    assert_redirected_to(:controller=>:login, :action=>:login)
  end

  test "should create post" do
    #only logged in users
    session[:user_id] = 10
    assert_difference('Post.count') do
      post :create, :post => {:description=>"test", :user_id=>10, :parent_id=>nil }
    end
   # assert_redirected_to posts_path
 end


  test "should destroy post" do
    session[:user_id] = posts(:post).user_id
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:post).id
    end

    assert_redirected_to posts_path
  end
  
  test "should allow search by any user" do
    session[:user_id] = nil
    get :search,{:srch_criteria=>1, :search=>"kkk"}
    assert_response :success
    assert_not_nil assigns(:posts)
  end
end
