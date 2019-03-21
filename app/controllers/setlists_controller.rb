class SetlistsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]

  def show
    @setlist = Setlist.find(params[:id])
    @musician = Musician.find(@setlist.musician_id)
    @songs = @setlist.songs.order('trackorder ASC')
  end

  def new
    @musician = Musician.find(params[:musician_id])
    @setlist = @musician.setlists.build
  end

  def create
    @setlist = current_user.setlists.build(setlist_params)

    if @setlist.save
      SetlistMailer.add_setlist_email(@setlist).deliver_now
      flash[:success] = 'セットリストを登録しました。'
      redirect_to @setlist
    else
      flash.now[:danger] = 'セットリストの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @setlist = Setlist.find(params[:id])
    @musician = Musician.find(@setlist.musician_id)
  end

  def update
    @setlist = Setlist.find(params[:id])
    @musician = Musician.find(@setlist.musician_id)

    if @setlist.update(setlist_params)
      flash[:success] = 'セットリストを登録しました。'
      redirect_to @setlist
    else
      flash.now[:danger] = 'セットリストの登録に失敗しました。'
      render :edit
    end
    
  end

  def destroy
    @musician = @setlist.musician
    @setlist.destroy
    flash[:success] = 'セットリストを削除しました。'
    redirect_to @musician
  end
  
  def add_song
    @setlist = Setlist.find(params[:id])
    @song = @setlist.songs.build(song_params)
    @musician = @setlist.musician
    
    if @song.save
      flash[:success] = '曲を追加しました。'
      redirect_to edit_setlist_url(@setlist)
    else
      flash.now[:danger] = '曲の追加に失敗しました。'
      render :edit
    end
  end
  
  def del_song
    @song = Song.find(params[:song_id])
    @setlist = @song.setlist
    @song.destroy
    flash[:success] = '曲を削除しました。'
    redirect_to @setlist
  end
  
  private

  def setlist_params
    params.require(:setlist).permit(:title, :date, :place, :musician_id, songs_attributes: [:id, :title, :trackorder])
  end
  
  def song_params
    params.permit(:title, :trackorder)
  end
  
  def correct_user
    @setlist = current_user.setlists.find_by(id: params[:id])
    unless @setlist
      redirect_to root_url
    end
  end
  
end
