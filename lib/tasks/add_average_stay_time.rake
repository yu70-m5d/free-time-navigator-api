namespace :add_average_stay_time do
  desc '平均滞在時間追加'
  task add_time: :environment do
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)
    spot = Spot.find(1)
    pp spot.latitude
    pp spot.longitude
    result = client.spots_by_query(spot.name).first
    pp result
    # client.spots(spot.latitude, spot.longitude, :detail => true).each do |result|
    #   pp "カウント"
    #   pp result
    #   if result.name === spot.name
    #     puts "タイプ"
    #     pp result.name
    #     pp result.types
    #   end
    # end
    # spots.each do |spot|
    #   lat = spot.latitude
    #   lng = spot.longitude

    #   result =  client.spots(lat, lng)

    #   pp result.name
    #   pp result.types

    #   # if spot.name === result.name

    # end
  end
end