class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(uid, time)
    # Do something later
    client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV["LINE_MESSAGENG_ID"]
      config.channel_secret = ENV["LINE_MESSAGING_SECRET"]
      config.channel_token = ENV["LINE_MESSAGING_ACCESS_TOKEN"]
    end

    message = {
      type: 'text',
      text: "通知を設定した時間は#{time}です。"
    }

    client.push_message(uid, message)
  end
end
