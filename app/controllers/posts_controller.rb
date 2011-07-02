class PostsController < ApplicationController
  layout "default"
  # GET /posts
  # GET /posts.xml
  def index
    
    @posts = Post.find(:all,:conditions => "parent_id IS NULL" )
    
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  #if a post is a reply, it has its parent_id set to the original post. else, parent_id is nil
  def new
    @post = Post.new
    if params[:id]
      @post.parent_id = params[:id]
    else
      @post.parent_id = nil
    end
    
    # @post.parent_id = params[:parent_id]
    respond_to do |format|
      format.html 
      # format.js { render :template => 'index', :layout => false }
      #format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    #respond_to do |format|
      #do not allow editing others posts unless you are admin. redirect to index
    if (!is_post_by_user(session[:user_id], @post) && !is_admin_user?)
      flash[:notice] = "You cannot edit this post"
      redirect_to(:action =>"index") 
      #    format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      
    end
  end
  
  # POST /posts
  # POST /posts.xml
  def create
    #if session[:user_id] != nil
    @post = Post.new(params[:post])
    @post.user_id = session[:user_id] 
    #@post.parent_id = session[:parent_id]
    respond_to do |format|
      if @post.save
        format.html { redirect_to(:action=>"index", :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
    #else
    # format.html { redirect_to(:controller=>:login, :action => :login)}
    #end
  end
  
  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    if (is_post_by_user(session[:user_id], @post)||is_admin_user?)
      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    if @post != nil
      
      if (is_post_by_user(session[:user_id], @post) || is_admin_user?)
        respond_to do |format|
          if @post.destroy
            format.html { redirect_to(posts_url, :notice => 'Post was successfully deleted.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "delete" }
            format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
          end  
        end
      end
    end
  end
  
  def search
    # @post = Post.find(params[:search])
    
    search_what = params[:srch_criteria]
    search_condition = "%" + params[:search] + "%"
    if search_what == "1" #text
      
      @posts = Post.find(:all, :conditions => ['description LIKE ?',search_condition])
    elsif search_what == "2" #by username
      users = User.find(:all, :conditions => ['user_name LIKE ?', search_condition])
      @posts = Array.new
      for user1 in users do 
        @posts = @posts | Post.find_all_by_user_id(user1.id)
          
      end
    end
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end
  
  
  
  before_filter :protect, :except => [:index, :show, :search]
  
  
  private
  # Protect a page against not logged users
  def protect
    unless session[:user_id]
      flash[:notice] = "Please login first"
      redirect_to :controller=>:login, :action => :login
      return false
    end
  end
  
  
end