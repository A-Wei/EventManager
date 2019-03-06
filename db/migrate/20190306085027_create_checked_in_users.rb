class CreateCheckedInUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :checked_in_users, primary_key: false do |t|
      t.references :event, null: false
      t.references :user, null: false
      t.datetime :checked_in_at
      t.datetime :checked_out_at

      t.timestamps
    end

    add_index(:checked_in_users, [:event_id, :user_id], unique: true)
  end
end
