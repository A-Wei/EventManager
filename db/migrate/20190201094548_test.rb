class Test < ActiveRecord::Migration[5.2]
  def change
    create_table :test do |t|
      t.string :name
    end
  end
end
