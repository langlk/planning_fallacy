class ChangeCheckinOwnership < ActiveRecord::Migration[5.1]
  def change
    remove_column :checkins, :user_id
    add_column :checkins, :account_id, :integer
    add_index :checkins, :account_id
  end
end
