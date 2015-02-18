class VideosController < ApplicationController
  load_and_authorize_resource :game
  load_and_authorize_resource through: :game

  def create
    if @video.save
      redirect_to game_path(@game), notice: "Created video"
    else
      render "games/show"
    end
  end

  private
  def video_params
    params.require(:video).permit(:title, :thumbnail, :category, :embed)
  end
end
