class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to user_path(current_user) and return
    else
      @setlists = Setlist.last(5)
      render :layout => nil and return
    end
  end

  def description
  end
end
