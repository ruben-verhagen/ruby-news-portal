class FrontController < ApplicationController
  before_action :prepare_new_subscriber
  before_action :fetch_search_filter
  before_action :prepare_common_js_data
  before_action :set_cookies
  before_action :sign_out_expired_user
  before_action :check_sso_registration_params

  layout 'front'

  def prepare_new_subscriber
    @new_user = User.new(user_group: 'trial_registrant')
  end

  protected

  def prepare_common_js_data
    gon.userLoggedIn = current_user.present?
  end

  def sign_out_expired_user
    if current_user && current_user.email_registrant?
      sign_out(current_user)
    end
  end

  def set_cookies
    CookiesWriter.new(cookies, current_user).set_cookies
  end

  def fetch_search_filter
    @search_filter = OpenStruct.new(params[:search_filter])
  end

  def apply_posts_scope(scope)
    scope.published
  end

  def check_sso_registration_params
    sso_u = params[:sso_u]
    sso_a = params[:sso_a]

    if sso_u.present? && sso_a.present?
      redirect_to new_user_session_path(sso_u: sso_u, sso_a: sso_a)
    end
  end
end