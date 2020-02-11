class Comment < ApplicationRecord
  after_commit :send_message
  belongs_to :user
  belongs_to :post

  private

  def send_message
    CommentJob.perform_later(self.post_id)
  end
end
