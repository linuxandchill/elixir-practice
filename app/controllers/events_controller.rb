class EventsController < ApplicationController
  def new
  end

  def show
    @event = Event.find(params[:id])
    @scheduled_at = { scheduled_at: @event.scheduled_at }.to_json
  end

  def edit
    @event = Event.find(params[:id])
    return redirect_to root_path if !current_user || @event.user != current_user
  end

  def toggle_subscription
    require 'sidekiq/api'
    return render json: { message: 'toggled' } unless current_user

    event = Event.find(params[:id])
    subs = current_user.subscriptions.where(event: event)
    if subs.any?
      # Cancel scheduled job
      jobid = subs.first[:jobid]
      p 'Trying to remove job ' + jobid
      scheduled_set = Sidekiq::ScheduledSet.new
      scheduled_set.each do |job|
        p job
        job.delete if job.jid == jobid
      end
      # Remove subscription from db table
      subs.destroy_all
    else
      # Schedule a subscription job
      remind_time = event[:scheduled_at] - 1.hour
      jobinstance = SubscriptionMailerJob.set(wait_until: remind_time).perform_later(current_user, event)
      # Add subscription to db table
      current_user.subscriptions.create!(event: event, jobid: jobinstance.provider_job_id)
    end
    redirect_to event_path(event.id, event.slug)
  end
end
