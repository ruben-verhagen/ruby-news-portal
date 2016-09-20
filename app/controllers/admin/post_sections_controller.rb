class Admin::PostSectionsController < AdminController
  def index
    @post_sections = PostSection.order(:name)
  end

  def new
    @post_section = PostSection.new
  end

  def create
    @post_section = PostSection.new(post_section_params)

    if @post_section.save
      flash[:success] = 'Post section was successfully created'
      redirect_to admin_post_sections_path
    else
      flash[:error] = "Can't create post section. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @post_section = PostSection.friendly.find(params[:id])
  end

  def update
    @post_section = PostSection.friendly.find(params[:id])

    if @post_section.update_attributes(post_section_params)
      flash[:success] = 'Post section was successfully updated'
      redirect_to admin_post_sections_path
    else
      flash[:error] = 'Please checkout the post section updating errors'
      render 'edit'
    end
  end

  def destroy
    @post_section = PostSection.friendly.find(params[:id])
    if @post_section.present?
      @post_section.destroy
      flash[:success] = 'Section was successfully removed'
    end

    redirect_to admin_post_sections_path
  end

  protected

  def post_section_params
    params.require(:post_section).permit(:name, :cover, :remove_cover, :parent_id, :description, :in_top_menu, :remove_cover)
  end
end