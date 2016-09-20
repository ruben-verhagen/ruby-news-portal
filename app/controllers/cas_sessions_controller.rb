require 'addressable/uri'

class CasSessionsController < Devise::CasSessionsController
  def new
    session[:redirect_url] = request.referrer
    super
  end

  def service
    if session[:redirect_url].present?
      url = session[:redirect_url]
      session[:redirect_url] = nil
      warden.authenticate!(:scope => resource_name)
      redirect_to url

      return
    end

    super
  end

  private

  def cas_login_url
    login_url = ::Devise.cas_client.add_service_to_login_url(::Devise.cas_service_url(request.url, devise_mapping))

    sso_u = params[:sso_u]
    sso_a = params[:sso_a]
    if sso_u.present? && sso_a.present?
      uri = Addressable::URI.parse(login_url)
      uri.query_values = { sso_u: sso_u, sso_a: sso_a }.merge(uri.query_values)
      login_url = uri.to_s
    end

    login_url
  end

  helper_method :cas_login_url
end
