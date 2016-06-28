class DailyMailer < ApplicationMailer
  default from: 'news@queueflow.com'

  def digest(user)
    @greeting = "Hi"
    @questions = Question.daily_delivery
    mail to: user.email, subject: 'What new in our site?'
  end
end
