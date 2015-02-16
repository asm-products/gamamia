class GamesController < ApplicationController
  before_filter :auth_user, only: [:upvote, :unupvote, :create]
  def index
    @weeks = Game.scheduled.display_order.group_by{|x| x.scheduled_at.beginning_of_week }.sort.reverse
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @comment = Comment.new
    @video = Video.new
    @related_games = @game.find_related_platforms.first(3)
  end

  def upvote
    @game = Game.find(params[:id])
    @game.upvote_by(current_user)
    redirect_to :back
  end

  def unupvote
    @game = Game.find(params[:id])
    @game.unvote_by(current_user)
    redirect_to :back
  end

  def upload
    uploaded_io = params[:game][:thumbnail]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  private
  def game_params
    params.require(:game).permit(:title, :thumbnail, :description, :status, :link, platform_list: [])
  end
end
