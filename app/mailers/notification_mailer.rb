class NotificationMailer < ApplicationMailer
  default from: 'notification@queueflow.com'

  def new_answer(answer, user)
    @answer   = answer
    @question = answer.question
    @email = user.email

    mail to: @email, subject: 'Hey, new answer on your question.'
  end
end
