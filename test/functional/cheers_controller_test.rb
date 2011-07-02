require 'test_helper'

class CheersControllerTest < ActionController::TestCase
  fixtures :posts
  test "should not cheer own post" do
    session[:user_id] = posts(:post).user_id
    get :new, :id=>posts(:post).id
    #assert_response :success
    assert_equal(flash[:notice],"You cannot cheer your own post")
    assert_redirected_to(:controller=>:posts, :action=>:index)
  end

  end
