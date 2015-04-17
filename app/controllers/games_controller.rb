class GamesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :js

  def index
    @current_week = params[:week].present? ? Date.parse(params[:week]) : Date.today.beginning_of_week
    @last_week = @current_week - 7.days
    @next_week = @current_week + 7.days

    @platforms = Game.scheduled.tags_on(:platforms)

    @games = @games.with_platform(params[:platform]) if params[:platform].present?

    @weeks = @games.includes(:user, :platforms).where("scheduled_at >= ? and scheduled_at < ?", @current_week, @next_week).scheduled.display_order.group_by do |game|
      params[:view] == "weekly" ? game.scheduled_at.beginning_of_week : game.scheduled_at
    end.sort.reverse
  end

  def new
  end

  def create
    @game.user = current_user
    if @game.save
      flash[:notice] = "Thanks for submitting, your submission is under review. You'll be emailed if and when your submission is scheduled"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @video = Video.new
    @related_games = @game.find_related_platforms.scheduled.first(3)
    @comments = @game.comments.where(parent_id: nil).preload(:user, children: :user).order('updated_at desc')
    flash.now[:notice] = "This game is under review." unless @game.scheduled_at?
  end

  def upvote
    if @game.scheduled_at?
      @game.upvote_by(current_user)
    else
      flash[:error] = "Sorry. You can't vote on unpublished games"
    end

    respond_to do |format|
      format.js do
        @game.scheduled_at? ? render(:vote) : render(js: "window.location = '#{game_path(@game)}'")
      end
      format.html { redirect_to :back }
    end
  end

  def unupvote
    @game.unvote_by(current_user)
    respond_to do |format|
      format.js { render :vote }
      format.html {redirect_to :back}
    end
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
