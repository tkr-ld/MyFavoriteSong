class MusicianRelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    musician = Musician.find(params[:musician_id])
    current_user.favorite(musician)
    flash[:success] = 'Musicianをお気に入りに追加しました'
    redirect_to musician
  end

  def destroy
    musician = Musician.find(params[:musician_id])
    current_user.unfavorite(musician)
    flash[:success] = 'Musicianをお気に入りから解除しました'
    redirect_to musician
  end
end
