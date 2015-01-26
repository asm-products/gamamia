class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @comment = Comment.new
    @video = @game.videos.new
  end

  def vote
    @game = Game.find(params[:id])
    @game.vote_by voter: current_user, vote: vote_param
    redirect_to games_path
  end

  def upload
    uploaded_io = params[:game][:thumbnail]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  private
  def vote_param
    params.require(:direction)
  end

  def game_params
    params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform)
  end
end
