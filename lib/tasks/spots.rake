namespace :spots do
  desc '施設情報取得new'
  task get_places: :environment do
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)
    lat = 35.7122128
    lng = 139.7779244
    radius = 1500
    tags = Tag.all
    types = []
    tags.each {|tag| types << tag.name}

    # 約500リクエスト
    types.each do |type|
      client.spots(lat, lng, types: type, language: 'ja', radius: radius).each do |result|
        puts "---------------------------------------------------------"
        place = Spot.new

        def remove_emoji(string)
          emoji_regex = /\p{Emoji}/
          string.gsub(emoji_regex, '')
        end

        place.name = remove_emoji(result.name)
        place.address = result.vicinity
        place.latitude = result.lat
        place.longitude = result.lng
        place.rating = result.rating
        place.place_id = result.place_id

        p place

        if result.photos[0].present?
          image_url = result.photos[0].fetch_url(800)
          place.image = image_url
        end

        if place.save
          puts "SpotSave!!"
          puts type
          puts place.name
          result.types.each do |tag_name|
            tag = Tag.find_by(name: tag_name)
            if tag.present?
              tagging = Tagging.new(spot_id: Spot.last.id, tag_id: tag.id)
              if tagging.save
                puts "TaggingSave!!"
              else
                puts "TaggingFALSE!!"
                pp tagging.errors
              end
            else
              next
            end
          end
        else
          puts "SpotFALSE!!"
          pp place.errors
          next
        end
      end
    end
  end

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

    latitude = 35.6899573
    longitude = 139.7005071

    radius = 1500

    types.each do |type|
      client.spots( latitude, longitude, :language => 'ja', :types => type, :radius => radius, :detail => true).each do |spot|

        puts "--------------------"
        add_db_spot = Spot.new
        add_db_spot.name = spot.name
        add_db_spot.address = spot.vicinity
        add_db_spot.latitude = spot.lat
        add_db_spot.longitude = spot.lng
        add_db_spot.rating = spot.rating
        add_db_spot.place_id = spot.place_id

        if spot.photos[0].present?
          image_url = spot.photos[0].fetch_url(800)
          add_db_spot.image = image_url
        end

        pp add_db_spot

        if add_db_spot.save
          puts "SpotSave!!"
          spot.types.each do |tag_name|
            tag = Tag.find_by(name: tag_name)
            if tag.present?
              tagging = Tagging.new(spot_id: Spot.last.id, tag_id: tag.id)
              if tagging.save
                puts "TaggingSave!!"
              else
                puts "TaggingFALSE!!"
                pp tagging.errors
              end
            else
              next
            end
          end

        else
          puts "SpotFALSE!!"
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

  desc '施設取得テスト'
  task get_spots_test: :environment do
    Geocoder.configure( :language => :ja )
    api_key = Rails.application.credentials.api&.fetch(:google_api_key)
    client = GooglePlaces::Client.new(api_key)
    tags = Tag.all
    types = []
    tags.each do |tag|
      types << tag.name
    end

    latitude = 35.6899573
    longitude = 139.7005071


    type = 'cafe'

    radius = 1000

    # types.each do |type|
    #   client.spots(35.54358, 139.4448397, :language => 'ja', :types => type).each do |spot|

    #     puts "--------------------"
    #     pp spot
    #   end
    # end
    # pp client.spot("ChIJey6Ne7P-GGARWGOMcxPW8GQ", language: 'ja')
    count = 0
    next_page_token = []

    client.spots(latitude, longitude, :language => 'ja', :types => type, :radius => radius).each do |spot|
      count += 1
      result = Geocoder.address("#{spot.lat}, #{spot.lng}")
      pp spot
      pp result
      pp count

    end
  end

  desc 'リバースジオコーディング'
  task reverse_geocoding: :environment do
    Geocoder.configure( :language => :ja )
    lat = 35.662055
    lng = 139.702655
    result = Geocoder.address("#{lat}, #{lng}")
    pp result
  end

  desc '重心取得'
  task get_center: :environment do
    lat1 = 35.69638888
    lng1 = 139.78305555
    lat2 = 35.68583333
    lng2 = 139.73000000
    lat3 =35.70527777
    lng3 = 139.77000000

    lat_center = ( lat1 + lat2 + lat3 ) / 3
    lng_center = ( lng1 + lng2 + lng3 ) / 3
    pp lat_center
    pp lng_center
  end

  desc '絵文字'
  task remove_emoji: :environment do
    def remove_emoji(string)
      emoji_regex = /\p{Emoji}/

      string.gsub(emoji_regex, '')
    end
    name1 = "ミニワン・ドンクエディテ 🥐ペリエ西船橋店"
    name2 = "ミニワン・ドンクエディテ"
    name_1 = remove_emoji(name1)
    name_2 = remove_emoji(name2)

    p name_1
    p name_2
  end
end
