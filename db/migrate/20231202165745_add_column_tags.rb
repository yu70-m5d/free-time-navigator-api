class AddColumnTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :stay_time, :integer
  end
end
