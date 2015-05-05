class Platform < ActiveRecord::Base
  has_many :game_platforms
  has_many :games, through: :game_platforms
end
