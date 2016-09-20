module Admin; end

class AdminController < ApplicationController
  before_action :authenticate_admin_user! if Rails.env.production?
  before_action :set_preview_post_mode

  layout 'admin'

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  protected

  def set_preview_post_mode
    session[:post_preview_id] = nil
  end

  def paginate_params
    { page: params[:page], per_page: params[:per_page] }
  end
end