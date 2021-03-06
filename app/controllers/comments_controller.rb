class CommentsController < ApplicationController
  before_action :authorize_request

  # POST /comments
  def create
    @comment = @current_user.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:description, :post_id)
  end
end
