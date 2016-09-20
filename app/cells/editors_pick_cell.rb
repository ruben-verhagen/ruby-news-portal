class EditorsPickCell < FrontendCell
  POSTS_COUNT = 10
  def show
    @user = current_user
    @posts = apply_posts_scope(Post.authors_pick.ranked).limit(POSTS_COUNT)
    render
  end
end
