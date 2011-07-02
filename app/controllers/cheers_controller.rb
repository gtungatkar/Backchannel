class CheersController < ApplicationController
  # GET /cheers
  # GET /cheers.xml
  layout "default"
  
  # GET /cheers/new
  # GET /cheers/new.xml
  def new
    #@cheer = Cheer.new(params[:id])
    post_id = params[:id]
    if session[:user_id] != nil
    post = Post.find_by_id(post_id)
    if post.user_id != session[:user_id] #do not allow cheering of own posts
    @cheer = Cheer.find_by_post_id_and_user_id(post_id, session[:user_id])
    #if post found, it is already cheered, dont cheer again. Else, new cheer
    if @cheer == nil
      @cheer = Cheer.new
      @cheer.post_id = post_id
      @cheer.user_id = session[:user_id]
      @cheer.rating = 1
      @cheer.save
    else
      flash[:notice] = "You can cheer a post only once"
    end
  else
    flash[:notice] = "You cannot cheer your own post"
  end
  end
   # respond_to do |format|
      redirect_to(:controller=>:posts, :action=>:index)
    #  format.xml  { render :xml => @cheer }
    #end
  end

 end