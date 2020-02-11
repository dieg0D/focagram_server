class CommentJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    @comments = Post.find(post_id).post_comments_serialized

    ActionCable.server.broadcast(post_id, coder: ActiveSupport::JSON, content: @comments)
  end
end
