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


    message = {
      type: 'text',
      text: "まもなく、#{time}です！"
    }

    client.push_message(uid, message)
  end
end
