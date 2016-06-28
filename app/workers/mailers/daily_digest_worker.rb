class Mailers::DailyDigestWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'default'

  def perform
    User.find_each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end
end
