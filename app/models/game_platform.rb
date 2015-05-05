class GamePlatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :platform

  validates :game,
            uniqueness: { scope: :platform }

  validates :url, url: { allow_blank: true }
end
