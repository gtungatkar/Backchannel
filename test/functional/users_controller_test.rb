require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user=>{:user_name=>"gaurav", :password=>"gaurav"}
    end

    assert_redirected_to(:controller=>:posts, :action=>:index)
  end

end
