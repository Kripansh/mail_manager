class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :email
      t.string :encrypted_password
      t.string :provider
      t.bigint :account_id
      t.bigint :fetch_interval

      t.timestamps
    end
  end
end
