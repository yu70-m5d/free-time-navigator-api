require 'line/bot'

class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(uid, time)
    # Do something later
    client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.line&.fetch(:line_messaging_id)
      config.channel_secret = Rails.application.credentials.line&.fetch(:line_messaging_secret)
      config.channel_token = Rails.application.credentials.line&.fetch(:line_messaging_access_token)
    end

    now_time = Time.now

    message = {
      type: 'text',
      text: "#{now_time}です。通知を設定した時刻になりました！"
    }

    client.push_message(uid, message)
  end
end
