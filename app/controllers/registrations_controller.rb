class RegistrationsController < Devise::RegistrationsController
  def create
    if params[:confirmation] == "true"
      @user = User.new(user_params)
      if @user.save
        @auth = Authorization.where(uid: params[:uid], 
          provider: params[:provider]).first
        @auth.update_attribute(:user_id, @user.id)
        ConfirmationMailer.email_confirmation(@user).deliver_now
        flash[:notice] = 'Message with confirmation sended on your email'
        redirect_to root_path
        return true
      end
    end
    super
  end

  private

  def user_params
    password = Devise.friendly_token[0..15]
    token    = Devise.friendly_token
    {
      email:    "dummy#{token[0..5]}@mail.ru",
      password: password,
      password_confirmation: password,
      confirmation_token: token,
      confirmation_sent_at: Time.now,
      unconfirmed_email: params[:user][:email]
    }
  end
end
