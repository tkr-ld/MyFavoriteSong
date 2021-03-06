class SongsController < ApplicationController
  def create
    setlist = Setlist.find(params[:setlist_id])
    song = setlist.songs.build(song_params)

    if song.save
      flash[:success] = '曲を追加しました。'
      redirect_to setlist_edit_track_url(setlist)
    else
      #エラーメッセージがあればフラッシュとして表示する
      if song.errors.any?
        song.errors.full_messages.each do |message|
          flash[:success] = message
        end
      else
        flash[:success] = '曲を追加に失敗しました。'
      end
      redirect_to setlist_edit_track_url(setlist)
    end
  end

  def destroy
    song = Song.find(params[:id])
    setlist = song.setlist
    song.destroy
    flash[:success] = '曲を削除しました。'
    redirect_to setlist_edit_track_url(setlist)
  end

  private

  def song_params
    params.require(:song).permit(:title, :trackorder)
  end
end
