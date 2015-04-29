class GameDeveloper < ActiveRecord::Base
  validates :thumbnail, presence: true
  validates :title, presence: true
  validates :location, presence: true

  has_many :games
end
