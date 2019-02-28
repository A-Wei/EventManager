class AddNameIndexForUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :name, using: 'gin'
  end
end
