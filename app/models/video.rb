class Video < ActiveRecord::Base
  belongs_to :game, counter_cache: true
  validates_presence_of :embed
end
