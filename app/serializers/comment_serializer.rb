class CommentSerializer < ApplicationSerializer
  attributes :content, :created_at, :anchor
  has_one :user

  def url
    game_path(object.game, anchor: anchor)
  end
end
