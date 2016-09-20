class EuroPollController < FrontController
  def index
    @post = apply_posts_scope(Post.ranked).first
  end
end