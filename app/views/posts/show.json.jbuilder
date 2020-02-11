@user = {
  username: @post.user.username,
  avatar_url: @post.user.avatar_url,
}

json.id @post.id
json.description @post.description
json.picture_url @post.picture_url
json.created_at @post.created_at

json.comments @post.comments do |comment|
  @author = {
    username: comment.user.username,
    avatar_url: comment.user.avatar_url,
  }

  json.id comment.id
  json.description comment.description
  json.author @author
end

json.user @user
