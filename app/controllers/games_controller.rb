class GamesController < ApplicationController
  def index
    @days = Game.scheduled.display_order.group_by{|x| x.scheduled_at.to_date }
  end

  def new
    @game = Game.new
  end

  def create
    authenticate_user!
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
  end

  def upvote
    authenticate_user!
    @game = Game.find(params[:id])
    @game.upvote_by(current_user)
    redirect_to :back
  end

  def unupvote
    authenticate_user!
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
    params.require(:game).permit(:title, :thumbnail, :description, :status, :link, :platform)
  end
end
