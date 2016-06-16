class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :load_and_authorize_user, :facebook, :twitter

  def facebook; end

  def twitter; end

  private
  
  def load_and_authorize_user
    provider = request.env['omniauth.auth'].provider
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    @auth = @user.authorizations.where(:provider == provider).first
    if @user.persisted? && @auth.access?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      @auth.save
      render 'devise/confirmations/email'
    end
  end
end
