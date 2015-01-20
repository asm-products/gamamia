class GamesController < ApplicationController
  before_filter :check_admin, only: [:new, :create, :destroy]

  def index
    @games = Game.all
    render 'games/admin/index' if params[:layout] == 'admin'
  end

  def show
    @game = Game.find(params[:id])
    @video = @game.videos.new
    render 'games/admin/show' if params[:layout] == 'admin'
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

  def upload
    uploaded_io = params[:game][:thumbnail]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path(layout: 'admin'), notice: "Destroyed game"
  end

  private
  def vote_param
    params.require(:direction)
  end

  def game_params
    params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform)
  end
end
