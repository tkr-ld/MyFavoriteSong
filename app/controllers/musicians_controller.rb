class MusiciansController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]

  def index
    @musicians = Musician.search(params[:search])
    #logger.debug(@musicians.map(&:name))
    number = @musicians.count
    flash.now[:success] = number.to_s + '件の検索結果が見つかりました'
    render :search
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
      flash[:success] = 'Musician は正常に更新されました'
      redirect_to @musician
    else
      flash.now[:danger] = 'Musician は更新されませんでした'
      render :edit
    end
  end

  private

  def musician_params
    params.require(:musician).permit(:name, :detail, :image)
  end
  
end
