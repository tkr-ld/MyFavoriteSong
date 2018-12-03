class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to user_path(current_user) and return
    else
      render :layout => nil and return
    end
  end
end

