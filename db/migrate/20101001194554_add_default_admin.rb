class AddDefaultAdmin < ActiveRecord::Migration
  def self.up
    User.create :id=>1,
                :user_name=>"admin",
                :password=>User.create_hashed_password("admin"),
                :admin=>1
                
  end

  def self.down
  end
end
