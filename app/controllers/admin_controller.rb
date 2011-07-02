#Implements admin-special functionality
#Manage Users view allows admins to delete a user, make any user as admin, revoke admin status from
#existing user.
class AdminController < ApplicationController
  layout "default"
  
  def index
    @posts = Post.find(:all, :conditions => "parent_id IS NULL")
  end
  
  #redirect to manage page
  def manage
    @users = User.find(:all)
    respond_to do |format|
      format.html # manage.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  #allow admins to delete a user whose id is passed in the HTTP PUT
  #redirects to admin/index
  def deleteuser
    if session[:admin_user] == true
      user = User.find_by_id(params[:id])
      user.post.each do|p|
        p.destroy
      end
    user.destroy
    flash[:notice] = "Succesfully deleted"
    else
    flash[:notice] = "Sorry! You are not admin"
    end
  
  
  redirect_to :controller=>:admin,:action=>"index"
  end

#allow an admin to set the "admin" flag of another user thereby granting him admin privileges
def makeadmin
  if session[:admin_user] == true
    user = User.find_by_id(params[:id])
    user.admin = 1
    user.save
    flash[:notice] = "Succesfully Given Admin Priveleges"
  else
    flash[:notice] = "Sorry! You are not admin"
  end
  
  redirect_to :controller=>:admin,:action=>"index"
end

#allow admin to reset the admin flag for a user
def revokeadmin
  if session[:admin_user] == true
    user = User.find_by_id(params[:id])
    user.admin = 0
    user.save
    flash[:notice] = "Succesfully Revoked Admin Priveleges"
  else
    flash[:notice] = "Sorry! You are not admin"
  end
  
  redirect_to :controller=>:admin,:action=>"index"
end

#Give user activity: For a particular user name,find count of his posts and total of cheers
def user_activity
  # @post = Post.find(params[:search])
  
  search_what = params[:user_activity]
  search_condition = "%" + search_what + "%"
  
  @ccount = 0
  user = User.find_by_user_name(params[:user_activity])
  if user.nil?
    flash[:notice] = "User not found"
  else
    @pcount = user.post.count
    postss = user.post.find(:all)
    postss.each do |p|
      if p != nil
        
        @ccount = @ccount + Cheer.find_all_by_post_id(p.id).size
        
      end
    end
    #@ccount = Post.cheer.rating.count
  end
  
  respond_to do |format|
    format.html
    format.xml  { render :xml => @post }
  end
end

end
