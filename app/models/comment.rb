class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, counter_cache: true
end
