class GameSerializer < ActiveModel::Serializer
  attributes :title, :description, :platform, :link
  attributes :thumbnail
  attributes :link
  attributes :url
  attributes :comments_count, :votes_up

  has_one :user

  def thumbnail
    object.thumbnail.url
  end

  def votes_up
    object.cached_votes_up
  end

  def url
    game_path(object)
  end
end
