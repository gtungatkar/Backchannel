require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :post
  has_many :cheer
  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  
  validate :password_not_blank
  
  
  def plnpassword
    @plnpassword
  end
  def plnpassword=(pwd)
    @plnpassword = pwd
    return if pwd.blank?
    self.password = User.create_hashed_password(@plnpassword)
  end
  
  def self.authenticate(user_name, password)
    user = self.find_by_user_name(user_name)
    if user
      pwd = User.create_hashed_password(password)
      if user.password != pwd
        return nil
      end
    end
    user
  end
private
  def self.create_hashed_password(plainpwd)
    Digest::SHA1.hexdigest(plainpwd)
  end
 def password_not_blank
    if blank?
      errors.add_to_base("Password Missing!" )
    end
  end

end
