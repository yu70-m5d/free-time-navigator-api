class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.references :user, null: false
      t.references :tag

      t.string :title, null:false
      t.text :content

      t.timestamps
    end
    add_index :todos, [:user_id, :tag_id]
  end
end
