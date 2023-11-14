class AddPlaceIdToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :place_id, :string, unique: true
  end
end
