class SetlistRelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    setlist = Setlist.find(params[:setlist_id])
    current_user.join(setlist)
    flash[:success] = 'セットリストを参加したライブに追加しました'
    redirect_to setlist
  end

  def destroy
    setlist = Setlist.find(params[:setlist_id])
    current_user.unjoin(setlist)
    flash[:success] = 'セットリストを参加したライブから解除しました'
    redirect_to setlist
  end
end
