module Admin
  class GamesController < ApplicationController
    load_and_authorize_resource
    def index
      @games = @games.order(:scheduled_at)
    end

    def show
      @video = @game.videos.new
    end

    def edit
    end

    def update
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
      @game.soft_destroy
      redirect_to admin_games_path, notice: "Destroyed game"
    end

    private
    def game_params
      params.require(:game).permit(:title, :thumbnail, :description, :extended_description, :status, :link, :scheduled_at, platform_list: [])
    end
  end
end
