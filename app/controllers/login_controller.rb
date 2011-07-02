class LoginController < ApplicationController
  layout "default"
  def login
    session[:user_id] = nil
    session[:admin_user] = false
    if request.post?
      user = User.authenticate(params[:user_name], params[:password])
      if user != nil
        flash.now[:notice] = "Successful"
        session[:user_id] = user.id
        session[:user_name] = user.user_name
        if user.admin == 1 #This is an administrator
          session[:admin_user] = true
          redirect_to(:controller => :admin, :action => "index" )
        else
          session[:admin_user] = false
          redirect_to(:controller => "posts", :action => "index" )
        end
        
      else
        flash.now[:notice] = "Invalid user/password combination"
        params[:password] = nil
        render(:action => "login" )     
      end
    end
    
  end
  
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:admin_user]= false
    flash[:notice] = "Logged out"
    redirect_to(:action => "login" )
    
  end
  
  def index
    redirect_to(:action => "login")
  end
  

  
end
