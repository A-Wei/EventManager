class CreateCheckedInUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :checked_in_users, primary_key: false do |t|
      t.references :event
      t.references :user

      t.timestamps
    end

    add_index(:checked_in_users, [:event_id, :user_id], unique: true)
  end
end
