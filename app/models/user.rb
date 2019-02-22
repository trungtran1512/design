class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  validates :email, uniqueness: true,
                    format: { with: /.+@.+\..+/, message: "Invalid email format" },
                    presence: false,
                    length: { maximum: 255, message: "Please re-enter the email with a length of 255 characters" }

  validates :username, uniqueness: true, presence: true, length: { in: 2..50, message: "Invite to re-enter the user name in lengths from 2 to 50 characters" }

  validates :fullname, presence: true, length: { maximum: 50, message: "Invite to re-enter the full name in lengths maximum 50 characters" }

  validates :phone, presence: true,
                    numericality: true,
                    length: { minimum: 10, maximum: 14, message: "Invite to re-enter the phone number format from 10 to 14 numbers" },
                    format: { with: /^\d{2,4}\-?\d{2,4}\-?\d{2,4}$/, multiline: true, message: "Invalid phone number format please re-enter" }

  validates :location, length: { maximum: 100, message: "The maximum length is 100 characters" }, presence: true

end