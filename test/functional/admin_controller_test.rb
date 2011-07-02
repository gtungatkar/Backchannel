require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  fixtures "users"
  test "the truth" do
    assert true
  end
  
  test "only admin can delete user" do
    session[:admin_user] = true
    assert_difference('User.count', -1) do
      delete :deleteuser, :id => users(:rohan).id
    end
    
  end
  
  test "only admin can make other admins" do
    session[:admin_user] = true
    session[:user_id] = users(:rohan).id
    post :makeadmin, :id=>users(:gaurav).id
    assert_equal(flash[:notice], "Succesfully Given Admin Priveleges")
    
    #non-admins cannot do this
    session[:admin_user] = false
    session[:user_id] = users(:gaurav).id
    post :makeadmin, :id=>users(:rohan).id
    assert_equal(flash[:notice], "Sorry! You are not admin")
    
  end
  
  test "show user activity" do
    get :user_activity ,{:user_activity=>users(:rohan).user_name}
    assert_response :success
  end
  
end
