class CreateTicketReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_replies do |t|
      t.references :ticket
      t.references :replier, polymorphic: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
