class AuthorsController < FrontController
  def show
    @author = Author.friendly.find(params[:id])
    @posts = apply_posts_scope(@author.posts.ranked)
  end
end