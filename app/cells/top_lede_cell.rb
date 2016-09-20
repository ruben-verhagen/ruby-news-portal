class TopLedeCell < FrontendCell
  def sidebar
    @user = current_user
    @post = apply_posts_scope(Post.top_lede.ranked).first
    if @post
      render
    else
      render nothing: true
    end
  end
end
