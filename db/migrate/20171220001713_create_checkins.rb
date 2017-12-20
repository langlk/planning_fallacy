class CreateCheckins < ActiveRecord::Migration[5.1]
  def change
    create_table :checkins do |t|
      t.string :name
      t.datetime :event_time
      t.integer :lateness
      t.integer :user_id

      t.timestamps
    end

    add_index :checkins, :user_id
  end
end
