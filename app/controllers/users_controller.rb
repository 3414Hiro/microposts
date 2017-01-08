class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followers, :followings]
  before_action :user_match, only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :followings, :followers]
  
  def index
    @users = User.all
  end
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to current_user , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @users = @user.following_users
  end
  
  def followers
    @users = @user.follower_users
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :bio)
  end
  
  def user_match
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end
end
