class SubscriptionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(user, event)
    SubscriptionsMailer.send_upcoming_event(user, event).deliver
  end

end
