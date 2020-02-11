json.id @user.id
json.name @user.name
json.username @user.username
json.avatar @user.avatar_url
json.posts_count @posts.length
json.comments_count @comments.length

json.posts @posts do |post|
  json.id post.id
  json.description post.description
  json.created_at post.created_at
  json.picture_url post.picture_url
  json.user @user
end
