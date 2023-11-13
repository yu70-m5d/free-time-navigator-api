class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude, limit: 53, null: false
      t.float :longitude,limit: 53, null: false
      t.float :rating
      t.time :average_stay_time
      t.string :image

      t.timestamps
    end
    add_index :spots, :name, unique: true
  end
end
