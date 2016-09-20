class CookiesWriter
  def initialize(cookies, user)
    @cookies = cookies
    @user = user
  end

  def set_cookies
    @previous_cookies = @cookies.dup
    set_user_data
  end

  protected

  def set_user_data
    if @user && @user.cookies_enabled?
      @cookies[:role] = @user.user_group
      if expired?
        @cookies[:show_expired_trial] = true
      else
        if week_before_expiration? && !seen_week_expiration_popup?
          @cookies[:show_week_expiration_popup] = true
        elsif few_days_before_expiration? && !seen_few_days_expiration_popup?
          @cookies[:show_few_days_expiration_popup] = true
        end
      end
    end
  end

  def set_user_state
    @cookies[:state] = user_signed_out? ? 'signed_out' : 'signed_in'
  end

  def user_signed_out?
    @previous_cookies[:role].in? %w(trialist subscriber) && !@user
  end

  def expired?
    @user.email_registrant? && (@user.previous_user_group == 'trialist' || @user.previous_user_group == 'subscriber')
  end

  def week_before_expiration?
    expires_at = @user.expires_at
    if expires_at.present? && @user.trialist?
      before_expiration = expires_at - Time.zone.now

      before_expiration.in? (2.days..7.days)
    end
  end

  def few_days_before_expiration?
    expires_at = @user.expires_at
    if expires_at.present? && @user.trialist?
      before_expiration = expires_at - Time.zone.now

      before_expiration.in? (0..2.days)
    end
  end

  def seen_week_expiration_popup?
    @cookies[:seen_week_expiration_popup]
  end

  def seen_few_days_expiration_popup?
    @cookies[:seen_few_days_expiration_popup]
  end

end