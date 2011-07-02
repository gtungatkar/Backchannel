# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "default"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  helper_method :find_user
  def find_user(id)
    #User.find(:first, :conditions => [ "id = ?", id ])
    User.find_by_id(id)
  end
  
  helper_method :current_user
  def current_user
    if session[:user_id] != nil
      @current_user = find_user(session[:user_id])
    else
      @current_user =  nil
    end
  end
  
  helper_method :same_user?
  def same_user?(user)
    logged_user = current_user
    return true if logged_user && logged_user.id == user.id
    false
  end
  
  helper_method :is_logged_in?
  def is_logged_in?
    return true if session[:user_id]!=nil
    false
  end
  
  #return true if this post is by this user
  helper_method :is_post_by_user
  def is_post_by_user(userid, post)
    if userid == post.user.id
      return true
    else
      return false
    end
  end
  helper_method :is_admin_user?
  def is_admin_user?
    return true if session[:admin_user]==true
    false
  end
  #layout proc{ |c| c.params[:format] == "js" ? false : "blank" }
end
