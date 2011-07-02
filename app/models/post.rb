class Post < ActiveRecord::Base
  belongs_to :user
  has_many :cheer
  belongs_to :parent,
  :class_name => "Post"
  has_many :children,
  :class_name => "Post",
  :foreign_key=>"parent_id",
  :order=> "created_at",
  :dependent =>:destroy

validates_presence_of :description
end
