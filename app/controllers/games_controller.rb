class GamesController < ApplicationController
  load_and_authorize_resource
  def index
    @weeks = @games.includes(:user, :platforms).scheduled.display_order.group_by{|x| x.scheduled_at.beginning_of_week }.sort.reverse
  end

  def new
  end

  def create
    @game.user = current_user
    if @game.save
      flash[:notice] = "Thanks, your game has been submitted. We will review it and let you know if it is scheduled"
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @video = Video.new
    @related_games = @game.find_related_platforms.first(3)
  end

  def upvote
    @game.upvote_by(current_user)
    redirect_to :back
  end

  def unupvote
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
