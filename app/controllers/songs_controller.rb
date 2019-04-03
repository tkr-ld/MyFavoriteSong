class SongsController < ApplicationController
  def create
  end

  def destroy
    song = Song.find(params[:id])
    setlist = song.setlist
    song.destroy
    flash[:success] = '曲を削除しました。'
    redirect_to setlist_edit_song_url(setlist)
  end
end
