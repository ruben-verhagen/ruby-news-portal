class Admin::EmailAlertsController < AdminController
  include Admin::ApplicationHelper

  before_action :find_email_alert, only: [:show, :destroy]
  before_action :prepare_common_settings_data, only: [:common_settings, :update_common_settings]
  before_action :prepare_custom_texts_data, only: [:custom_texts, :update_custom_texts]

  def index
    @email_alerts = EmailAlert.latest.paginate(paginate_params)
  end

  def new
    @email_alert = EmailAlert.new
    @email_alert.subject = 'MNI Euro Insight / Latest news'
    @email_alert.save(validate: false)

    redirect_to admin_email_alert_common_settings_path(@email_alert)
  end

  def common_settings
  end

  def update_common_settings
    @email_alert.attributes = email_alert_common_params
    if @email_alert.save
      @email_alert.ready!

      redirect_to admin_email_alert_custom_texts_path(@email_alert)
    else
      render 'common_settings'
    end
  end


  def custom_texts
  end

  def update_custom_texts
    if @email_alert.sent?
      redirect_to admin_email_alerts_path, flash: { error: "You can't send one alert twice" }

      return
    end

    if @email_alert.update_attributes(email_alert_texts_params)
      email_alert_posts = EmailAlertsPost.find(@email_alert.email_alerts_post_ids)
      greeting_message = prepare_for_html(@email_alert.greeting_message || '')

      if MailgunService.new.send_posts email_alert_posts, @email_alert.user_groups, @email_alert.subject, greeting_message
        @email_alert.sent!
        flash[:success] = 'Email alert was successfully sent'
      else
        @email_alert.failed!
        flash[:error] = 'Email alert sending failed. Please retry later'
      end

      redirect_to admin_email_alert_path(@email_alert)
    else
      flash[:error] = 'Email alert text is invalid. Please fix the errors below'
      render 'custom_texts'
    end

  end

  def destroy
    if (@email_alert.initial? || @email_alert.ready?) && @email_alert.destroy
      redirect_to admin_email_alerts_path, flash: { success: 'Email alert was successfully destroyed' }
    else
      redirect_to admin_email_alerts_path, flash: { error: "Can't destroy email alert" }
    end
  end


  protected

  def find_email_alert
    @email_alert = EmailAlert.find(params[:id])
  end

  def prepare_common_settings_data
    @email_alert = EmailAlert.find(params[:email_alert_id])
    @step = :common_settings
    @posts = @email_alert.posts && Post.published.latest.limit(20)
  end

  def prepare_custom_texts_data
    @email_alert = EmailAlert.find(params[:email_alert_id])
    @step = :custom_texts
    @email_alerts_posts = @email_alert.email_alerts_posts
  end

  def email_alert_common_params
    params.require(:email_alert).permit(user_groups: [], post_ids: [])
  end

  def email_alert_texts_params
    params.require(:email_alert).permit(:greeting_message, :subject, email_alerts_posts_attributes: [:description, :id, :headline])
  end
end