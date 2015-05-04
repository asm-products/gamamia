module Admin
  class GameDevelopersController < ApplicationController
    load_and_authorize_resource

    def new
    end

    def edit
    end

    def create
      if @game_developer.save
        redirect_to admin_game_developers_path
      else
        render :new
      end
    end

    def update
      if @game_developer.update_attributes(game_developer_params)
        redirect_to admin_game_developers_path
      else
        render :edit
      end
    end

    def destroy
      @game_developer.destroy
      redirect_to admin_game_developers_path, notice: "Destroyed game developer"
    end

    private
    def game_developer_params
      params.require(:game_developer).permit(:title, :location, :thumbnail)
    end
  end
end
