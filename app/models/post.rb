class Post < ApplicationRecord

  belongs_to :user, optional: true

  URL_DATA = "https://news.ycombinator.com/best"

  DEFAULT_IMAGE = "https://s3-us-west-2.amazonaws.com/design-image/hacker_news/no-image.jpg"

  scope :sort_time, -> { order('created_at desc') }

  scope :published, -> { where(published: true) }

  mount_uploader :image, ImageUploader

  validates :user_id, numericality: { only_integer: true }, allow_nil: true

  validates :title, presence: true, length: { in: 2..50, message: "Invite to re-enter the title in lengths from 2 to 50 characters" }

  validates :discription, presence: true, length: { maximum: 255, message: "Invite to re-enter the description in lengths maximum 255 characters" }

end