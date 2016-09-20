class Admin::LandingPagesController < AdminController
  def index
    @landing_pages = LandingPage.paginate(paginate_params)
  end

  def edit
    @landing_page = LandingPage.find(params[:id])
  end

  def new
    @landing_page = LandingPage.new
  end

  def create
    @landing_page = LandingPage.new(landing_page_params)

    if @landing_page.save
      flash[:success] = 'Landing Page was successfully created'

      redirect_to admin_landing_pages_path
    else
      flash[:error] = 'Please checkout the landing page updating errors'
      render 'new'
    end
  end

  def update
    @landing_page = LandingPage.find(params[:id])

    if @landing_page.update_attributes(landing_page_params)
      flash[:success] = 'Landing Page was successfully updated'

      redirect_to admin_landing_pages_path
    else
      flash[:error] = 'Please checkout the landing page updating errors'
      render 'edit'
    end
  end

  def destroy
    @landing_page = LandingPage.find(params[:id])

    if @landing_page.destroy
      flash[:success] = 'Landing Page was successfully removed'
    else
      flash[:error] = 'Unable to remove landing page'
    end

    redirect_to admin_landing_pages_path
  end

  protected

  def landing_page_params
    params.require(:landing_page).permit(:title, :subdomain, :meta_description, :thanks_content, :left_column_content, :center_column_content, :right_column_content)
  end
end