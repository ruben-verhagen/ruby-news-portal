class UsersController < FrontController
  before_action(:authenticate_user!, except: :create) if Rails.env.production?

  before_action :find_user, only: [:edit, :update]

  def create
    @new_user = User.find_by(email: subscriber_params[:email], user_group: 'email_registrant') ||
                User.new(user_group: 'trial_registrant')

    if @new_user.update_attributes(subscriber_params)
      ApplicationMailer.new_subscriber_email(@new_user).deliver
      CookiesWriter.new(cookies, @new_user).set_cookies

      MailgunService.new.send_subscription_message(@new_user) if @new_user.user_setting.email_alerts


      render '_success', layout: false
    else
      flash[:error] = 'This email is invalid or has been already used'
      render '_form', layout: false
    end
  end

  def invite_request
    if (@new_user = User.find_by(email: subscriber_params[:email], user_group: 'trialist'))
      ApplicationMailer.new_subscriber_email(@new_user).deliver
      render '_short_form_success', layout: false
    else
      @new_user = User.new(email: subscriber_params[:email])
      flash[:error] = "We can't find the user with such email"
      render '_short_form', layout: false
    end
  end

  def short_create
    @new_user = User.find_by(email: subscriber_params[:email], user_group: 'email_registrant')

    if @new_user
      if @new_user.trial_registrant!
        ApplicationMailer.new_subscriber_email(@new_user).deliver
        CookiesWriter.new(cookies, @new_user).set_cookies

        render '_short_form_success', layout: false
      else
        flash[:error] = 'This email can\'t be registered as trial registrant once again.'

        render '_short_form', layout: false
      end
    else
      flash[:error] = 'This email can\'t be  found or can not be registered as trial registrant'
      @new_user = User.new

      render '_short_form', layout: false
    end
  end

  def edit
    @user.settings
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice: 'Your settings were successfully changed'
    else
      render 'edit', error: 'There were errors'
    end
  end


  protected

  def find_user
    @user = current_user
    raise ActionController::RoutingError.new('Not Found') unless @user
  end

  def user_params
    params.require(:user).permit(user_setting_attributes: [:email_alerts])
  end

  def subscriber_params
    params.require(:user).permit(:first_name, :last_name, :company, :title, :phone_number, :email, :country,
                                 user_setting_attributes: [:cookie])
  end
end