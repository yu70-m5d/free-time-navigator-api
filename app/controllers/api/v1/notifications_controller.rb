class Api::V1::NotificationsController < ApplicationController
  def send_push_notification

    uid = request.headers['uid']
    time = params[:time]

    # 受け取った時間をDateTimeオブジェクトに変換する
    scheduled_time = Time.zone.parse(time) - 5.minute

    # 現在時刻から受け取った時間までの遅延（秒数）を計算する
    delay = (scheduled_time - Time.zone.now).to_i

    SendPushNotificationJob.set(wait: delay.seconds).perform_later(uid, time)
    # SendPushNotificationJob.set(wait: 0.seconds).perform_later(uid, time)


    render json: { message: "OK" }, status: :ok
  end
end
