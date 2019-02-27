require 'elasticsearch/model'

class Post < ApplicationRecord
  belongs_to :user, optional: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mount_uploader :image, ImageUploader

  validates :user_id, numericality: { only_integer: true }, allow_nil: true

  validates :title, presence: true, length: { in: 2..50, message: "Invite to re-enter the title in lengths from 2 to 50 characters" }

  validates :discription, presence: true
end