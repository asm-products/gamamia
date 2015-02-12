class Game < ActiveRecord::Base

  STATUS_TYPES = ["released", 0], ["beta",1]
  PLATFORM_TYPES = ["PC", 0], ["Mac", 1], ["Linux", 2], ["iOS", 3], ["Android", 4], ["Windows Phone", 5]

  has_many :videos
  has_many :comments

  default_scope -> { where(deleted_at: nil) }

  scope :unscheduled, -> { where(scheduled_at: nil) }
  scope :scheduled, -> { where('scheduled_at <= ?', Date.today) }
  scope :display_order, -> { order(:scheduled_at).reverse_order }

  acts_as_votable

  mount_uploader :thumbnail, ThumbnailUploader

  def soft_destroy
    touch(:deleted_at)
    freeze
  end

end
