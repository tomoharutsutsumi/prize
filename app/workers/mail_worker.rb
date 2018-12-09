class MailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailers

  def perform(giver_id, given_id)
    UserMailer.giving_award_email(giver_id, given_id).deliver_later
  end
end
