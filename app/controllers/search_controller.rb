class SearchController < FrontController
  PER_PAGE = 10

  def index
    @posts = apply_posts_scope(Post.ranked)
    if @search_filter.search_query.present?
      @posts = @posts.joins(:authors).where('headline ILIKE :name OR byline ILIKE :name OR content ILIKE :name OR authors.name ILIKE :name',
                                            name: "%#{@search_filter.search_query.downcase}%")
    end

    @posts = @posts.distinct.paginate(page: params[:page], per_page: PER_PAGE)

    @next_page_path = search_path(@search_filter.to_h.merge(page: @posts.next_page))

    respond_to do |format|
      format.js { render }
      format.html { render }
    end
  end
end