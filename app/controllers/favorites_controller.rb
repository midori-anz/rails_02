class FavoritesController < ApplicationController
  def index
    @favorite_topics = current_user.favorite_topics
  end

  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.topic_id = params[:topic_id]

    if favorite.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りの登録に失敗しました'
    end
  end
  
  def destroy
      favorite = Favorite.find_by(user_id: current_user.id, topic_id: params[:topic_id])
      favorite.destroy if favorite.present?
      if favorite.destroyed?
        redirect_to topics_path, success: 'お気に入りを解除しました'
      else
        redirect_to topics_path, danger: 'お気に入り解除に失敗しました'
      end
  end
end