class Admin::GraphsController < AdminController
  def index
    @graphs = Graph.order(:name)
  end

  def new
    @graph = Graph.new
  end

  def create
    @graph = Graph.new(graph_params)

    if @graph.save
      prepare_float_params
      flash[:success] = 'Graph was successfully created'
      redirect_to admin_graphs_path
    else
      flash[:error] = "Can't create Graph. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @graph = Graph.friendly.find(params[:id])
    @simple = (@graph.code == 'euro_poll')
  end

  def update
    @graph = Graph.friendly.find(params[:id])
    @graph.assign_attributes(graph_params)
    prepare_float_params

    if @graph.save
      flash[:success] = 'Graph was successfully updated'
      redirect_to admin_graphs_path
    else
      flash[:error] = 'Please checkout the Graph updating errors'
      render 'edit'
    end
  end

  def destroy
    @graph = Graph.friendly.find(params[:id])
    if @graph.present?
      @graph.destroy
      flash[:success] = 'Section was successfully removed'
    end

    redirect_to admin_graphs_path
  end

  protected

  def prepare_float_params
    [:spread_min, :spread_max, :existing,  :median_3, :median_6, :median_9, :median_12, :average_3, :average_6,
     :average_9, :average_12, :high_3, :high_6, :high_9, :high_12, :low_3, :low_6, :low_9, :low_12].each do |field|
      @graph.send("#{field}=", @graph.send(field).to_f)
    end
  end

  def graph_params
    params.require(:graph).permit(:name, :description, :spread_min, :spread_max, :existing,
                                  :median_3, :median_6, :median_9, :median_12, :average_3, :average_6, :average_9, :average_12,
                                  :high_3, :high_6, :high_9, :high_12, :low_3, :low_6, :low_9, :low_12,
                                  :period_3_name, :period_6_name, :period_9_name, :period_12_name)
  end
end