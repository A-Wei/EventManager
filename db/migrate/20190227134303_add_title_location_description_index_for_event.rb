class AddTitleLocationDescriptionIndexForEvent < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :title
    add_index :events, :location
    add_index :events, :description
  end
end
