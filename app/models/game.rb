class Game < ActiveRecord::Base
  has_many :videos
  has_many :comments

  acts_as_votable
end
