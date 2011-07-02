require 'test_helper'

class PostsTest < ActionController::IntegrationTest
  fixtures :all
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "create new post before login" do
    visit "/posts"
    click_link "New Post"
    assert_contain('login first')
    fill_in "Username:", :with=>users(:gaurav).user_name
    fill_in "Password:", :with=>"helloworld"
    click_button "Login"
    assert_contain("Logged in as #{users(:gaurav).user_name}")
  end
  
  test "search for posts" do
  visit "/posts"
  fill_in "search", :with=> "test"
  choose :srch_criteria_1
  click_button "Search"
  assert_contain("Search Results")
  click_link "Home"
  fill_in "search", :with=> users(:gaurav).user_name
  choose :srch_criteria_2
  click_button "Search"
  assert_contain("Search Results")
end

test "create new post" do
  visit "/login"
  fill_in "Username:", :with=>users(:gaurav).user_name
  fill_in "Password:", :with=>"helloworld"
  click_button "Login"
  visit "/posts"
  click_link "New Post"
  fill_in "Description", :with=>"Hello"
  click_button "Create"
  assert_contain("Hello")
  
end
test "Delete post" do
  
visit "/login"
  fill_in "Username:", :with=>users(:gaurav).user_name
  fill_in "Password:", :with=>"helloworld"
  click_button "Login"
  visit "/posts"
  click_link "New Post"
  fill_in "Description", :with=>"Hello"
  click_button "Create"
  #new post created..now delete that
  
click_link "Delete"
  assert_not_contain("Hello")
end
end
