class CreateMailMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_messages do |t|
      t.bigint :email_unique_id
      t.text :message_content
      t.string :sender
      t.string :recipient
      t.string :cc
      t.string :bcc
      t.text :attachment_urls
      t.datetime :message_time

      t.timestamps
    end
  end
end
