class MusiciansController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]

  def index
    @musicians = @search.result
    number = @musicians.count
    @musicians = @musicians.page(params[:page])
    flash.now[:success] = number.to_s + '件の検索結果が見つかりました'
  end
  
  def show
    @musician = Musician.find(params[:id])
    @setlists = Setlist.where(musician_id: @musician.id).order(:date)
  end

  def new
     @musician = Musician.new
  end

  def create
    @musician = Musician.new(musician_params)

    if @musician.save
      flash[:success] = 'ミュージシャンを登録しました。'
      redirect_to @musician
    else
      flash.now[:danger] = 'ミュージシャンの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @musician = Musician.find(params[:id])
  end
  
  def update
    @musician = Musician.find(params[:id])
    
    if @musician.update(musician_params)
      flash[:success] = 'ミュージシャンは正常に更新されました'
      redirect_to @musician
    else
      flash.now[:danger] = 'ミュージシャンは更新されませんでした'
      render :edit
    end
  end

  private

  def musician_params
    params.require(:musician).permit(:name, :detail, :image)
  end
  
end
