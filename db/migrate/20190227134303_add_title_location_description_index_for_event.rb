class AddTitleLocationDescriptionIndexForEvent < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :title, using: 'gin'
    add_index :events, :location, using: 'gin'
    add_index :events, :description, using: 'gin'
  end
end
