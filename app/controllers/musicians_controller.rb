class MusiciansController < ApplicationController
  def index
    @musicians = Musician.search(params[:search])
    logger.debug(@musicians.map(&:name))
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
  
  private

  def musician_params
    params.require(:musician).permit(:name, :detail, :image)
  end
  
end
