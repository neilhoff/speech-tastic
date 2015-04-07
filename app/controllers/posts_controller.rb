class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.published.order(created_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, success: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.user = current_user
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, success: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def publish
    respond_to do |format|
      if @post.update_attribute(:published, true)
        format.html { redirect_to edit_post_path(@post), success: 'Post was successfully published .' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity, error: 'Could not publish the post at this time. Please try again later.' }
      end
    end
  end

  def unpublish
    respond_to do |format|
      if @post.update_attribute(:published, false)
        format.html { redirect_to edit_post_path(@post), success: 'Post was successfully unpublished.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity,  error: 'Could not unpublish the post at this time. Please try again later.' }
      end
    end
  end

  def all
    @posts = Post.all.order(created_at: :desc)
    render action: 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :published, :user_id)
    end
end
