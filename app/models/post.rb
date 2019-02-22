class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, numericality: { only_integer: true }, allow_nil: true
  validates :title, presence: true, length: { in: 2..50 }
  validates :discription, presence: true
  mount_uploader :image, ImageUploader
end
