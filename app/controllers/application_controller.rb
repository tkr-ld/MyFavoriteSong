class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def user_counts(user)
    @count_favorites = user.favorites.count
    @count_joined = user.joinlives.count
  end
  
  def musician_counts(musician)
    @count_setlists = user.setlists.count
  end
end
