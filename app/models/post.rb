class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_one_attached :picture
  has_many :comments

  def picture_url
    rails_blob_url(self.picture, only_path: true) if self.picture.attached?
  end

  def post_comments_serialized
    @comments = []
    self.comments.each do |comment|
      @author = {
        username: comment.user.username,
        avatar_url: comment.user.avatar_url,
      }

      @comment = {
        id: comment.id,
        description: comment.description,
        author: @author,
      }
      @comments.push(@comment)
    end
    @comments
  end
  
end
