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
end
