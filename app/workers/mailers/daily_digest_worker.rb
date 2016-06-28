class Mailers::DailyDigestWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'default'

  def perform
    logger.info "START processing daily digest"
    User.find_each do |user|
      DailyMailer.digest(user).deliver_later
    end
    logger.info "END build queue for daily digest"
  end
end
