class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:post_id]
  end

  def unsubscribed
    stop_all_streams
  end
end
