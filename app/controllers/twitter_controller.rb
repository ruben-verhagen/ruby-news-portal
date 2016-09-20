class TwitterController < ApplicationController
  def create
    @twitter_account = TwitterAccount.from_omniauth(auth_hash)

    if @twitter_account.valid?
      flash[:notice] = 'Account was successfully connected'
    else
      flash[:error] = 'Unable to connect account'
    end

    redirect_to admin_site_settings_path
  end

  def destroy
    @twitter_account = TwitterAccount.find(params[:id])
    @twitter_account.destroy

    redirect_to admin_site_settings_path, notice: 'Account was successfully removed'
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end