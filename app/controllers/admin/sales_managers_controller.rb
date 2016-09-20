class Admin::SalesManagersController < AdminController
  before_action :find_sales_manager, only: [:edit, :update, :destroy]

  def index
    @sales_managers = SalesManager.all.paginate(paginate_params)
  end

  def new
    @sales_manager = SalesManager.new
  end

  def create
    @sales_manager = SalesManager.new(sales_manager_params)

    if @sales_manager.save
      flash[:success] = 'Sales manager was successfully created'

      redirect_to admin_sales_managers_path
    else
      flash[:error] = "Can't create a sales manager. Checkout the errors below"
      render 'new'
    end
  end

  def edit

  end

  def update
    if @sales_manager.update_attributes(sales_manager_params)
      flash[:success] = 'Sales manager was successfully updated'

      redirect_to admin_sales_managers_path
    else
      flash[:error] = 'Please checkout the sales manager updating errors'
      render 'edit'
    end
  end

  def destroy
    @sales_manager.destroy if @sales_manager.present?

    redirect_to admin_sales_managers_path, flash: { success: 'Sales manager was successfully destroyed' }
  end

  protected
  def find_sales_manager
    @sales_manager = SalesManager.find(params[:id])
  end

  def sales_manager_params
    params.require(:sales_manager).permit(:name, :email, :trial_registrants)
  end
end
