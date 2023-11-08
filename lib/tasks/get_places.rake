namespace :get_places do
  desc '施設情報取得'
  task get_spots: :environment do
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    types = [ 'amusement_park', 'aquarium', 'art_gallery', 'bakery', 'bar',
              'beauty_salon', 'book_store', 'bowling_alley', 'cafe', 'casino',
              'city_hall', 'clothing_store', 'department_store', 'electronics_store', 'food',
              'furniture_store', 'grocery_or_supermarket', 'gym', 'hair_care', 'jewelry_store',
              'library', 'meal_takeaway', 'movie_theater', 'museum', 'night_club',
              'park', 'pet_store', 'pharmacy', 'post_office', 'restaurant',
              'shoe_store', 'shopping_mall', 'spa', 'zoo' ]

    # types = [ 'amusement_park', 'aquarium', 'art_gallery', 'bakery', 'bar' ]

    radius = 1000

    types.each do |type|
    #   puts "====================="
    #   puts "#{type}の検索結果"
    #   puts "---------------------"
    #   client.spots(35.5435083,139.4359084, :types => type, :radius => radius, :detail => true).each do |spot|
    #     puts spot.name
    #     puts spot.types
    #     puts spot.formatted_address
    #     puts spot.lat
    #     puts spot.lng
    #     puts spot.rating
    #     puts spot.url
    #     puts "--------------------"
    #   end
    # end
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
end
