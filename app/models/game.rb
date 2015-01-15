class Game < ActiveRecord::Base

  STATUS_TYPES = ["released", 0], ["beta",1]
  PLATFORM_TYPES = ["PC", 0], ["Mac", 1], ["Linux", 2], ["iOS", 3], ["Android", 4], ["Windows Phone", 5]

  has_many :videos
  has_many :comments

  acts_as_votable

  mount_uploader :thumbnail, ThumbnailUploader


end
