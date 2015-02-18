module Admin
  class GamesController < ApplicationController
    def index
      @games = Game.all.order(:scheduled_at)
    end

    def show
      @game = Game.find(params[:id])
      @video = @game.videos.new
    end

    def edit
      @game = Game.find(params[:id])
    end

    def update
      @game = Game.find(params.fetch(:id))
      scheduled_before = @game.scheduled_at?
      if @game.update_attributes(game_params)
        if !scheduled_before && @game.reload.scheduled_at?
          UserMailer.game_scheduled(@game).deliver_later
        end
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
      params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :scheduled_at, platform_list: [])
    end
  end
end
