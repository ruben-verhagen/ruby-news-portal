class Admin::PagesController < AdminController
  def index
    @pages = Page.paginate(paginate_params)
  end

  def edit
    @page = Page.friendly.find(params[:id])
  end

  def update
    @page = Page.friendly.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:success] = 'Page was successfully updated'

      redirect_to admin_pages_path
    else
      flash[:error] = 'Please checkout the page updating errors'
      render 'edit'
    end
  end

  protected

  def page_params
    params.require(:page).permit(:title, :content)
  end
end