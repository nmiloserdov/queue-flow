class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    load_user_and_authorizations
    if @user.persisted? && @auth.access?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      @auth.save
      render 'devise/confirmations/email'
    end
  end

  def twitter
    load_user_and_authorizations
    if @user.persisted? && @auth.access?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      @auth.save
      render 'devise/confirmations/email'
    end
  end

  private
  
  def load_user_and_authorizations
    provider = request.env['omniauth.auth'].provider
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    @auth = @user.authorizations.where(:provider == provider).first
  end
end
