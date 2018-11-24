class SetlistsController < ApplicationController
  def index
  end

  def show
    @setlist = Setlist.find(params[:id])
    @musician = Musician.find(@setlist.musician_id)
    @songs = @setlist.songs
  end

  def new
    @musician = Musician.find(params[:musician_id])
    @setlist = @musician.setlists.build
  end

  def create
    @setlist = current_user.setlists.build(setlist_params)

    if @setlist.save
      flash[:success] = 'セットリストを登録しました。'
      redirect_to @setlist
    else
      flash.now[:danger] = 'セットリストの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @setlist = Setlist.find(params[:setlist_id])
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
  end
  
  def add_song
    @setlist = Setlist.find(params[:id])
    @song = @setlist.songs.build(song_params)
    
    if @song.save
      flash[:success] = '曲を追加しました。'
      redirect_to @setlist
    else
      flash.now[:danger] = '曲の追加に失敗しました。'
      render :edit
    end
  end
  
  private

  def setlist_params
    params.require(:setlist).permit(:title, :date, :place, :musician_id, songs_attributes: [:id, :title, :order])
  end
  
  def song_params
    params.require(:song).permit(:title, :order)
  end
  
end
