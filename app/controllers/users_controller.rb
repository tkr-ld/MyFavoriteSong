class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites.last(5)
    @joinlives = @user.joinlives.last(5)
    user_counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.page(params[:page])
    user_counts(@user)
  end

  def joinlives
    @user = User.find(params[:id])
    @joinlives = @user.joinlives.page(params[:page])
    user_counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
