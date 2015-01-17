class VideosController < ApplicationController
  before_filter :init_game
  before_filter :check_admin

  def create
    video = @game.videos.new(video_params)
    if video.save
      redirect_to game_path(@game), notice: "Created video"
    else
      render "games/show"
    end
  end

  private
  def video_params
    params.require(:video).permit(:title, :thumbnail, :category, :embed)
  end

  def init_game
    @game = Game.find(params[:game_id])
  end
end
