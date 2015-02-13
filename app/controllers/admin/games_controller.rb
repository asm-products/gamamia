module Admin
  class GamesController < ApplicationController
    def index
      @games = Game.all.order(:scheduled_at)
    end

    def show
      @game = Game.find(params[:id])
      @video = @game.videos.new
    end

    def update
      @game = Game.find(params.fetch(:id))
      if @game.update_attributes(game_params)
        redirect_to admin_games_path
      else
        render 'new'
      end
    end

    def destroy
      @game = Game.find(params.fetch(:id))
      @game.soft_destroy
      redirect_to admin_games_path, notice: "Destroyed game"
    end

    private
    def game_params
      params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform, :scheduled_at)
    end
  end
end
