require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :users
  test "the truth" do
    assert true
  end
  
  
  test "invalid with no username" do
   user = User.new
   assert !user.valid?
 end
 
 test "username is not unique" do
   user = User.new
   user.user_name = users(:rohan).user_name
   user.password = "mypassword"
   user.id = (users(:rohan).id + 1)
   assert !user.valid?
   assert_equal("has already been taken", user.errors.on(:user_name))
 end
 test "password is encrypted" do
   user = User.new
   user.user_name = "john"
   user.plnpassword = "smith"
   user.save
   assert_not_equal(user.plnpassword, user.password, "password should encrypted" )
 end
 
 test "authenticate user" do
   user = User.new
   #create new user and save to database.
   user.user_name = "gaurav"
   user.plnpassword = "gaurav"
   user.save
   
   #assert that this new user can be authenticated
   assert User.authenticate(user.user_name, user.plnpassword)
 end
 
 
end
