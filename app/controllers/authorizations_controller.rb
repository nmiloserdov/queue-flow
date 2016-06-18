class AuthorizationsController < ActionController::Base

  def confirm
    load_user
    if @user.confirmation_token == params[:token]
      @user.confirm!
      flash[:notice] = "You are successfuly authorizated"
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to root_path
    end
  end

  private

  def load_user
    @user = User.find_by(unconfirmed_email: params[:email])
  end
end
