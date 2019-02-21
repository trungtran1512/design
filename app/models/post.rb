class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, numericality: { only_integer: true }, allow_nil: true
  validates :title, presence: true, length: { in: 2..50 }
  validates :discription, presence: true

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
