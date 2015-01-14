class GamesController < ApplicationController
  before_filter :check_admin, only: [:new, :create]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path
    else
      render 'new'
    end
  end

  def vote
    @game = Game.find(params[:id])
    @game.vote_by voter: current_user, vote: vote_param
    redirect_to games_path
  end

  private
  def vote_param
    params.require(:direction)
  end

  def game_params
    params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform)
  end
end
