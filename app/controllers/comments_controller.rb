class CommentsController < ApplicationController
  load_and_authorize_resource :game
  load_and_authorize_resource through: :game

  def create
    @comment.user = current_user
    if @comment.save
      redirect_to @game
    else
      flash[:error] = "Could not create comment"
      redirect_to @game
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
