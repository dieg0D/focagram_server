class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_secure_password
  has_one_attached :avatar
  has_many :posts
  has_many :comments

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def avatar_url
    rails_blob_url(self.avatar, only_path: true) if self.avatar.attached?
  end
end
