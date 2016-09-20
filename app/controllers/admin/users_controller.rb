class Admin::UsersController < AdminController
  before_action :find_user, only: [:edit, :update]
  def index
    users = User.all.order('created_at desc')
    @q = users.search(params[:q])

    @users = @q.result.paginate(paginate_params)
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated successfully'
      redirect_to admin_users_path
    else
      flash[:error] = "Can't update user. Check errors below."
      render 'edit'
    end
  end

  def export
    users = User.all
    @q = users.search(params[:q])

    csv_file = CSVBuilder.build_from_users @q.result

    send_data csv_file, type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: "attachment;filename=MNI-Euro-Insight-subscribers-export-#{Time.zone.now.strftime('%Y_%m_%d_%H_%M')}.csv"
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_group, :expires_at)
  end
end