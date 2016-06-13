class ConfirmationMailer < ApplicationMailer
  default from: 'support@queueflow.com'


  def email_confirmation(user)
    @email = user.unconfirmed_email
    @token = user.confirmation_token

    mail(to: user.unconfirmed_email, subject: 'Confirm your account')
  end
end
