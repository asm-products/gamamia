class Game < ActiveRecord::Base
	has_many :videos
	has_many :comments
	has_many :votes
end
