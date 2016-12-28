class UsersController < ApplicationController
  before_action :user_match, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
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
    @user = current_user
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to current_user , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :bio)
  end
  
  def user_match
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end
end
