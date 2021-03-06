class SetlistsController < ApplicationController
  require 'twitter'

  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :find_setlist, only: [:show, :edit, :update]

  def show
    @songs = @setlist.songs.order('trackorder ASC')

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end

    @tweets = []
    since_id = nil

    tweets = client.search("#{@setlist.musician.name} #{@setlist.place}", count: 7, result_type: "mixed", exclude: "retweets", since_id: since_id)
    add_tweets(tweets, 7)
    tweets = client.search(@setlist.title, count: 3, result_type: "mixed", exclude: "retweets", since_id: since_id)
    add_tweets(tweets,3)
  end

  def new
    musician = Musician.find(params[:musician_id])
    @setlist = musician.setlists.build
  end

  def create
    @setlist = current_user.setlists.build(setlist_params)

    if @setlist.save
      SetlistMailer.add_setlist_email(@setlist).deliver_now
      flash[:success] = 'セットリストを登録しました。'
      redirect_to setlist_edit_track_path(@setlist)
    else
      flash.now[:danger] = 'セットリストの登録に失敗しました。'
      redirect_to setlist_edit_track_path(@setlist)
    end
  end

  def edit
  end

  def edit_track
    @setlist = Setlist.find(params[:setlist_id])
    @song = Song.new
  end

  def update
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
  
  private

  def find_setlist
    @setlist = Setlist.find(params[:id])
  end

  def setlist_params
    params.require(:setlist).permit(:title, :date, :place, :musician_id, songs_attributes: [:id, :title, :trackorder])
  end
  
  def correct_user
    @setlist = current_user.setlists.find_by(id: params[:id])
    unless @setlist
      redirect_to root_url
    end
  end

  def add_tweets(tweets, n)
    tweets.take(n).each do |tw|
      tweet = Tweet.new(tw.full_text)
      @tweets << tweet
    end
  end
end
