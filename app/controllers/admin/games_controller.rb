module Admin
  class GamesController < ApplicationController
    def index
      @games = Game.all
    end

    def show
      @game = Game.find(params[:id])
      @video = @game.videos.new
    end

    def new
      @game = Game.new
    end

    def create
      @game = Game.new(game_params)
      if @game.save
        redirect_to admin_games_path
      else
        render 'new'
      end
    end

    def destroy
      @game = Game.find(params[:id])
      @game.destroy
      redirect_to admin_games_path, notice: "Destroyed game"
    end

    private
    def game_params
      params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform)
    end
  end
end
