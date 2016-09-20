class PagesController < FrontController
  def show
    @page = Page.friendly.find(params[:slug])
  end
end