class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_query
  
  include SessionsHelper
  
  private

  def set_query
    @search = Musician.ransack(params[:q])
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def user_counts(user)
    @count_favorites = user.favorites.count
    @count_joined = user.joinlives.count
  end
end
