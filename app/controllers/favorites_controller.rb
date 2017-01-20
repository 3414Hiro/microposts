class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
  end
  
  def destroy
    # Favorite.find(params[:id]).destroy
    @micropost = current_user.favorites.find(params[:id]).micropost
    # @micropost = current_user.favorite_microposts.find(params[:id]).micropost
    current_user.unfavorite(@micropost)
  end
  
end
