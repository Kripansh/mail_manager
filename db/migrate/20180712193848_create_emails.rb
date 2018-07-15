class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.text :subject
      t.bigint :profile_id
      t.datetime :mail_initiate_time
      t.boolean :starred
      t.boolean :important

      t.timestamps
    end
  end
end
