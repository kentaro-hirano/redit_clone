class PostsController < ApplicationController
  before_action :authenticate_account!, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :auth_subscriber, only: [:show]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_values)
    @post.account_id = current_account.id
    @post.community_id = params[:community_id]
    if @post.save
      redirect_to community_path(@post.community_id)
    else
      @community = Community.find(params[:community_id])
      render :new
    end
  end

    private
    
    def auth_subscriber
      unless Subscription.where(community_id: params[:community_id], account_id: current_account.id).any?
        redirect_to root_path, flash: {danger: "You are not authorized to view this page"}
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end
    def post_values
      params.require(:post).permit(:title, :body)
    end
end
