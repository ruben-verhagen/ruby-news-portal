class Admin::SiteSettingsController < AdminController
  def index
    @site_settings = SiteSetting.order(:id)
    @twitter_accounts = TwitterAccount.all
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @site_settings }
    end
  end

  def update
    @site_setting = SiteSetting.find(params[:site_setting][:id])

    @site_setting.update_attributes(site_setting_params)
    render json: @site_setting
  end

  protected

  def site_setting_params
    params.require(:site_setting).permit(:value)
  end
end