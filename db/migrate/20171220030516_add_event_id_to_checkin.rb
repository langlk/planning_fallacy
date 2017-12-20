class AddEventIdToCheckin < ActiveRecord::Migration[5.1]
  def change
    add_column :checkins, :event_id, :string
  end
end
