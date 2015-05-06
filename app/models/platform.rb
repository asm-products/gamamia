class Platform < ActiveRecord::Base
  has_many :game_platforms, dependent: :destroy
  has_many :games, through: :game_platforms
end
