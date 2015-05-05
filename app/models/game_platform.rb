class GamePlatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :platform
end
