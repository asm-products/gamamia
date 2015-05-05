class GamePlatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :platform

  validates :game,
            uniqueness: { scope: :platform }
end
