#require 'test/unit'
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures  :posts
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end


 test "invalid with empty description" do
   post = Post.new
   assert !post.valid?
 end
 
 test "unique post and user id" do
   post = Post.new(:id => posts(:post).id,
                   :description => "testpost",
                   :user_id => posts(:post).user_id)
   assert post.save
 end
end