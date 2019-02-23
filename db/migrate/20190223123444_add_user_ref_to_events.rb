class AddUserRefToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :user, foreign_key: true, type: :integer, null: false
  end
end
