class TopStoriesCell < FrontendCell
  def main
    @user = current_user
    scoped_posts = apply_posts_scope(Post.all)
    @top_posts = scoped_posts.for_carousel.rank(:carousel_rank).limit(5)

    @breaking_news_post = apply_posts_scope(Post.ranked).breaking_news.first

    if @top_posts.any?
      render
    else
      render nothing: true
    end
  end

  def sidebar
    @user = current_user
    @top_posts = apply_posts_scope(Post.last_week).by_views.ranked.limit(10)
    render
  end
end