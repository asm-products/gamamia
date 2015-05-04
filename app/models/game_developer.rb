class GameDeveloper < ActiveRecord::Base
  validates :title, presence: true
  validates :location, presence: true

  has_many :games

  mount_uploader :thumbnail, ThumbnailUploader
end
