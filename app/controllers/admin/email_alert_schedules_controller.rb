class Admin::EmailAlertSchedulesController < AdminController
  before_action :find_email_alert_schedule, only: [:edit, :show, :update, :destroy]

  def index
    @schedules = EmailAlertSchedule.paginate(paginate_params)
    render 'index'
  end

  def new
    @schedule = EmailAlertSchedule.new
  end

  def create
    @schedule = EmailAlertSchedule.new(schedule_params)
    if @schedule.save
      flash[:success] = 'Automatic Email alert schedule rule was successfully created'

      redirect_to admin_email_alert_schedules_path
    else
      flash[:error] = "Can't create a Automatic Email alert schedule rule. Checkout the errors below"
      @schedule.prepare_form_data
      render 'new'
    end
  end

  def edit
    @schedule.prepare_form_data
  end

  def show
    @automatic_alerts = @schedule.automatic_email_alerts.includes(:posts)
                          .where('created_at >= :date', date: Date.today.at_beginning_of_month).order('created_at desc')
  end

  def update
    @schedule.attributes = schedule_params
    if @schedule.save
      flash[:success] = 'Automatic Email alert schedule rule was successfully updated'

      redirect_to admin_email_alert_schedules_path
    else
      flash[:error] = 'Please check out the update errors below'
      render 'edit'
    end
  end

  def destroy
    if  @schedule.destroy
      flash[:success] = 'Automatic Email alert schedule rule was successfully destroyed'
    else
      flash[:error] = 'Can\'t destroy Email alert schedule rule '
    end

    redirect_to admin_email_alert_schedules_path
  end

  protected

  def find_email_alert_schedule
    @schedule = EmailAlertSchedule.find(params[:id])
  end

  def schedule_params
    params.require(:email_alert_schedule).permit(:send_at, :greeting_message, :form_send_at, user_groups: [], days_of_week: [])
  end
end