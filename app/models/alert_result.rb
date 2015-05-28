class AlertResult
  def initialize(alerts, date_range)
    @alerts = alerts
    @date_range = date_range
  end

  def run
    search_result = FeedEntry.search(Alert.search_options(@alerts, @date_range))

    search_result.alerts.each do |alert|
      alert.groups.each do |group|
        emails_to = []
        smses_to  = []

        group.members.each do |member|
          emails_to << member.email if member.email_alert
          smses_to  << member.phone if member.sms_alert
        end

        delay_time = ENV['DELAY_DELIVER_IN_MINUTES'].to_i.minutes

        if emails_to.length > 0 && alert.total_match > 0

          # delay, delay_for, delay_unitl
          AlertMailer.delay_for(delay_time).notify_matched(search_result.results_by_alert(alert.id),
                                                           alert.id,
                                                           group.name,
                                                           emails_to,
                                                           @date_range)
        end

        sms_time = Time.zone.now

        if smses_to.length > 0 && alert.total_match > 0 && alert.is_time_appropiate?(sms_time)
          smses_to.each do |sms|
            options = { from: ENV['APP_NAME'], to: "sms://#{sms}", body: alert.translate_message }
            # wait_until, wait
            SmsAlertJob.set(wait: delay_time).perform_later(options)
          end
        end
      end
    end
  end




end