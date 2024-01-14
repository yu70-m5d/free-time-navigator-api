namespace :tags do
  desc 'tagsテーブル作成'
  task create_tags_table: :environment do
    types = [ 'aquarium', 'art_gallery', 'bakery', 'bar', 'book_store',
              'cafe', 'clothing_store', 'department_store', 'electronics_store', 'food',
              'furniture_store', 'grocery_or_supermarket', 'library', 'meal_takeaway', 'movie_theater',
              'museum', 'park', 'pet_store', 'pharmacy', 'restaurant',
              'shoe_store', 'shopping_mall', 'spa', 'tourist_attraction', 'place_of_worship' ]

    types.each do |type|
      tag = Tag.create!(name: type)
    end

  end

  desc 'stay_time追加'
  task add_time: :environment do
    types_of_30min = [  'bakery', 'book_store', 'meal_takeaway', 'park', 'pet_store',
                        'pharmacy', 'grocery_or_supermarket', 'shoe_store'  ]
    types_of_60min = [  'clothing_store', 'department_store', 'electronics_store', 'furniture_store', 'shopping_mall',
                        'tourist_attraction', 'place_of_worship', 'cafe'  ]
    types_of_90min = [  'library' ]
    types_of_120min = [ 'aquarium', 'art_gallery', 'museum' ]
    types_of_150min = [ 'food', 'bar', 'movie_theater', 'restaurant'  ]
    types_of_180min = [ 'spa' ]

    tags = Tag.all
    tags.each do |tag|
      if types_of_30min.include?(tag.name)
        tag.stay_time = 30
      end
      if types_of_60min.include?(tag.name)
        tag.stay_time = 60
      end
      if types_of_90min.include?(tag.name)
        tag.stay_time = 90
      end
      if types_of_120min.include?(tag.name)
        tag.stay_time = 120
      end
      if types_of_150min.include?(tag.name)
        tag.stay_time = 150
      end
      if types_of_180min.include?(tag.name)
        tag.stay_time = 180
      end
      if tag.save
        puts "SUCCESS"
      else
        puts "FALSE"
      end
    end
  end
end
