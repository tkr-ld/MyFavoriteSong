class SetlistsController < ApplicationController
  def index
  end

  def show
    @setlist = Setlist.find(params[:id])
    @musician = Musician.find(@setlist.musician_id)
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
  end

  def update
  end

  def destroy
  end
  
  private

  def setlist_params
    params.require(:setlist).permit(:title, :date, :place, :musician_id)
  end
  
end
