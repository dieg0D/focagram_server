json.array! @posts do |post|
  @user = {
    username: post.user.username,
    avatar_url: post.user.avatar_url,
  }

  json.id post.id
  json.description post.description
  json.created_at post.created_at
  json.picture_url post.picture_url
  json.user @user
end
