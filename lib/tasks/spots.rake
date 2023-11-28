namespace :spots do
  desc '施設情報取得'
  task get_spots: :environment do
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)
    # types = [ 'amusement_park', 'aquarium', 'art_gallery', 'bakery', 'bar',
    #           'beauty_salon', 'book_store', 'bowling_alley', 'cafe', 'casino',
    #           'city_hall', 'clothing_store', 'department_store', 'electronics_store', 'food',
    #           'furniture_store', 'grocery_or_supermarket', 'gym', 'hair_care', 'jewelry_store',
    #           'library', 'meal_takeaway', 'movie_theater', 'museum', 'night_club',
    #           'park', 'pet_store', 'pharmacy', 'post_office', 'restaurant',
    #           'shoe_store', 'shopping_mall', 'spa', 'zoo' ]

    types = [ 'aquarium', 'art_gallery', 'bakery', 'bar', 'book_store',
              'cafe', 'clothing_store', 'department_store', 'electronics_store', 'food',
              'furniture_store', 'grocery_or_supermarket', 'library', 'meal_takeaway', 'movie_theater',
              'museum', 'park', 'pet_store', 'pharmacy', 'restaurant',
              'shoe_store', 'shopping_mall', 'spa' ]

    radius = 1000

    types.each do |type|
      client.spots(35.5435083,139.4359084, :types => type, :radius => radius, :detail => true).each do |spot|
        puts "--------------------"
        add_db_spot = Spot.new
        add_db_spot.name = spot.name
        add_db_spot.address = spot.formatted_address
        add_db_spot.latitude = spot.lat
        add_db_spot.longitude = spot.lng
        add_db_spot.rating = spot.rating

        if spot.photos[0].present?
          image_url = spot.photos[0].fetch_url(800)
          add_db_spot.image = image_url
        end

        pp add_db_spot

        if add_db_spot.save
          puts "SUCCESS!!"
        else
          puts "FALSE!!"
          pp add_db_spot.errors
          next
        end
      end
    end
  end

  desc '施設ID取得'
  task get_placeid: :environment do
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)

    spots = Spot.all
    spots.each do |spot|
      client.spots(spot.latitude, spot.longitude, name: spot.name, detail: true).each do |result|
        pp result.formatted_address
        if result.name == spot.name && result.formatted_address == spot.address
          puts "--------------------------------------------------"
          puts spot.id
          puts spot.name
          puts result.name
          puts spot.address
          puts result.formatted_address
          spot.place_id = result.place_id
          if spot.save
            puts "save"
          else
            puts "FAILED"
            pp spot.errors
          end
        end
      end
    end
  end

  desc '施設情報確認'
  task confirm_spot: :environment do
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)
    spot = Spot.find(12)
    result_of_name = client.spots_by_query(spot.name).first
    result_of_address = client.spots_by_query(spot.address).first
    client.spots(spot.latitude, spot.longitude, name: spot.name).each do |result|
      pp result
    end
    pp spot
    pp result_of_name
    pp result_of_address
  end

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
