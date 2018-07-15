class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.string :email
      t.string :phone
      t.string :business_name

      t.timestamps
    end
  end
end
