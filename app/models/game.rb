class Game < ActiveRecord::Base
	has_many :videos
	has_many :comments
end
