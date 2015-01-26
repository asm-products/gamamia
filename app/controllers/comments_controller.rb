class CommentsController < ApplicationController
  before_filter :set_game
  before_filter :user_logged_in?

  def create
    comment = @game.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to @game
    else
      render 'games/show'
    end
  end

  private
  def set_game
    @game = Game.find(params[:game_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
