class OpinionsCell < FrontendCell
  def sidebar
    @user = current_user
    @section = PostSection.find_by(code: :opinions)
    @post = apply_posts_scope(@section.posts.latest).first

    if @post
      render
    else
      render nothing: true
    end
  end
end
