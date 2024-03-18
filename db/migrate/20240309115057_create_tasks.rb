class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.references :tag

      t.string :title, null:false
      t.text :content

      t.timestamps
    end
    add_index :tasks, [:user_id, :tag_id]
  end
end
