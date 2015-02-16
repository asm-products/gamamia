class GameSerializer < ApplicationSerializer
  attributes :title, :description, :link
  attributes :thumbnail
  attributes :link
  attributes :platform_list
  attributes :comments_count, :votes_up

  has_one :user

  def platform_list
    object.platform_list.join(", ")
  end

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
