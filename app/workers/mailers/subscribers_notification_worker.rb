class Mailers::SubscribersNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'default'

  def perform(answer)
    answer = Answer.find(answer["id"])
    answer.question.subscriptions.each do |subscription|
      NotificationMailer.new_answer(answer, subscription.user).deliver_later
    end
  end
end
