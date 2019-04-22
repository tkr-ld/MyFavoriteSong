class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :find_user, only: [:show, :edit, :update]

  def show
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

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ミュージシャンは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ミュージシャンは更新されませんでした'
      render :edit
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

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
