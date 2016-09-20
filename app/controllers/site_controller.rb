class SiteController < FrontController
  def sitemap
    @posts = apply_posts_scope(Post.latest.limit(500))
    respond_to do |format|
      format.xml { render layout: false }
    end
  end

  def feed
    @posts = apply_posts_scope(Post.latest.limit(20))

    respond_to do |format|
      format.rss { render 'feed', layout: false }
    end
  end
end