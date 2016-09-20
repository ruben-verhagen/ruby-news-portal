class GraphsController < FrontController
  def show
    @all_graphs = Graph.all
    @graph = Graph.friendly.find(params[:id])
    @simple = (@graph.code == 'euro_poll')
    @post = apply_posts_scope(Post.ranked).first
    @opinion_section_id = PostSection.find_by(code: :opinions).try(:id)
  end
end