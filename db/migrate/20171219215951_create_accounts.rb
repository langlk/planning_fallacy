class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :access_token
      t.string :id_token
      t.string :refresh_token
      t.integer :expires_in

      t.timestamps
    end

    add_index :accounts, :user_id
  end
end
