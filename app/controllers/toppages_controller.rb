class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to user_path(current_user)
    end
    render :layout => nil
  end
end

