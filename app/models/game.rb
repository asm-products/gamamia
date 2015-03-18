class Game < ActiveRecord::Base
  STATUS_TYPES = ["released", 0], ["beta",1]

  acts_as_taggable_on :platforms

  validates :title, :link, presence: true

  has_many :videos
  has_many :comments
  belongs_to :user

  default_scope -> { where(deleted_at: nil) }

  scope :unscheduled, -> { where(scheduled_at: nil) }
  scope :scheduled, -> { where('scheduled_at <= ?', Date.today) }
  scope :display_order, -> { order(:cached_votes_up).reverse_order }
  scope :with_platform, -> (name) { tagged_with(name) }

  acts_as_votable

  mount_uploader :thumbnail, ThumbnailUploader

  def soft_destroy
    touch(:deleted_at)
    freeze
  end
end
