class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false
      t.references :spot, null:false

      t.timestamps
    end
    add_index :favorites, [:user_id, :spot_id], unique: true
  end
end
