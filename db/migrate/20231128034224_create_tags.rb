class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :stay_time

      t.timestamps
    end
    add_index :tags, :name, unique: true
  end
end
