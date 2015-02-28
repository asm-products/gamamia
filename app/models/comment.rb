class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, counter_cache: true

  belongs_to :parent, class_name: "Comment", foreign_key: :parent_id, touch: true
  has_many :children, class_name: "Comment", foreign_key: :parent_id

  validates_presence_of :content
end
