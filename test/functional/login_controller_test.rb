require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  fixtures :users
  test "the truth" do
    assert true
  end
  test "redirect to login" do
    get :index
    assert_redirected_to :action=> "login"
  end
  
  test "login success" do
    user = users(:rohan)
    post :login, :user_name => users(:rohan).user_name, :password=> "helloworld"
    if user.admin == 1
      assert_redirected_to(:controller=>:admin, :action=>:index)
    else
      assert_redirected_to(:controller=>:posts, :action => :index)
    end
    assert_equal users(:rohan).id, session[:user_id]
  end
  
end
