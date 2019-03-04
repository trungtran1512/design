class Post < ApplicationRecord
  belongs_to :user, optional: true

  scope :sort_time, -> { order('created_at desc') }

  scope :published, -> { where(published: true) }

  mount_uploader :image, ImageUploader

  validates :user_id, numericality: { only_integer: true }, allow_nil: true

  validates :title, presence: true, length: { in: 2..50, message: "Invite to re-enter the title in lengths from 2 to 50 characters" }

  validates :discription, presence: true
end