class Game < ActiveRecord::Base
  STATUS_TYPES = ["released", 0], ["beta",1]

  validates :title, :link, presence: true

  has_many :videos
  has_many :comments
  has_many :game_platforms, dependent: :destroy
  has_many :platforms, through: :game_platforms
  belongs_to :user
  belongs_to :game_developer

  accepts_nested_attributes_for :game_platforms, reject_if: :all_blank, allow_destroy: true

  default_scope -> { where(deleted_at: nil) }

  scope :unscheduled, -> { where(scheduled_at: nil) }
  scope :scheduled, -> { where('scheduled_at <= ?', Date.today) }
  scope :display_order, -> { order(:cached_votes_up).reverse_order }
  scope :with_platform, -> (name) { joins(:platforms).where(platforms: { name: name }) }

  acts_as_votable

  mount_uploader :thumbnail, ThumbnailUploader

  def soft_destroy
    touch(:deleted_at)
    freeze
  end

  def find_related_platforms
    Game
      .joins(:platforms)
      .where(platforms: { id: platforms.map(&:id) })
      .where.not(games: { id: id })
  end
end
