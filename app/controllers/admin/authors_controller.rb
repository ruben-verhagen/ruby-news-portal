class Admin::AuthorsController < AdminController
  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      flash[:success] = 'Post author was successfully created'
      redirect_to admin_authors_path
    else
      flash[:error] = "Can't create author. Check out the errors below"
      render 'new'
    end
  end

  def edit
    @author = Author.friendly.find(params[:id])
  end

  def update
    @author = Author.friendly.find(params[:id])

    if @author.update_attributes(author_params)
      flash[:success] = 'Post author was successfully updated'
      redirect_to admin_authors_path
    else
      flash[:error] = 'Please check out the author updating errors'
      render 'edit'
    end
  end

  def destroy
    @author = Author.friendly.find(params[:id])
    if @author.present?
      @author.destroy
      flash[:success] = 'Author was successfully removed'
    end

    redirect_to admin_authors_path
  end

  protected

  def author_params
    params.require(:author).permit(:name, :photo, :remove_photo)
  end
end