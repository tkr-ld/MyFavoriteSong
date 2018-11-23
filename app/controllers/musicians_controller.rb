class MusiciansController < ApplicationController
  def index
    @musicians = Musician.search(params[:search])
    logger.debug(@musicians.map(&:name))
    render :search
  end
  
  def show
    @musician = Musician.find(params[:id])
  end

  def new
     @musician = Musician.new
  end

  def create
    @musician = Musician.new(musician_params)

    if @musician.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @musician
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private

  def musician_params
    params.require(:musician).permit(:name, :detail, :image)
  end
  
end
