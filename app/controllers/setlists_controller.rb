class SetlistsController < ApplicationController
  require 'twitter'

  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]

  def show
    @setlist = Setlist.find(params[:id])
    @musician = @setlist.musician
    @songs = @setlist.songs.order('trackorder ASC')

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end

    @tweets = []
    since_id = nil

    tweets = client.search("#{@musician.name} #{@setlist.place}", count: 10, result_type: "mixed", exclude: "retweets", since_id: since_id)
    add_tweets(tweets)
    tweets = client.search(@setlist.title, count: 10, result_type: "mixed", exclude: "retweets", since_id: since_id)
    add_tweets(tweets)
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
      redirect_to edit_setlist_path(@setlist)
    else
      flash.now[:danger] = 'セットリストの登録に失敗しました。'
      redirect_to edit_setlist_path(@setlist)
    end
  end

  def edit
    @setlist = Setlist.find(params[:id])
  end

  def edit_song
    @setlist = Setlist.find(params[:setlist_id])
  end

  def update
    @setlist = Setlist.find(params[:id])
    @musician = @setlist.musician

    if @setlist.update(setlist_params)
      flash[:success] = 'セットリストを登録しました。'
      redirect_to @setlist
    else
      @setlist.errors.full_messages.each do |message|
        flash.now[:danger] = message
      end
      render :edit
    end
  end

  def destroy
    musician = @setlist.musician
    @setlist.destroy
    flash[:success] = 'セットリストを削除しました。'
    redirect_to musician
  end
  
  def add_song
    binding.pry
    setlist = Setlist.find(params[:id])
    song = setlist.songs.build(song_params)
    
    if song.save
      flash[:success] = '曲を追加しました。'
      redirect_to setlist_edit_song_url(setlist)
    else
      #エラーメッセージをフラッシュとして表示する
      if song.errors.any?
        song.errors.full_messages.each do |message|
          flash[:success] = message
        end
      else
        flash[:success] = '曲を追加に失敗しました。'
      end
      redirect_to setlist_edit_song_url(setlist)
    end
  end
  
  def delete_song
    song = Song.find(params[:song_id])
    setlist = song.setlist
    song.destroy
    flash[:success] = '曲を削除しました。'
    redirect_to setlist_edit_song_url(setlist)
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

  def add_tweets(tweets)
    tweets.take(10).each do |tw|
      tweet = Tweet.new(tw.full_text)
      @tweets << tweet
    end
  end
  
end
