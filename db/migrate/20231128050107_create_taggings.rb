class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.references :spot, null: false
      t.references :tag, null: false

      t.timestamps
    end
    add_index :taggings, [:spot_id, :tag_id], unique: true
  end
end
