class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.references :requester
      t.references :agent
      t.references :department_id
      t.references :ticket_template
      t.string :subject, null: false
      t.text :description
      t.integer :priority
      t.integer :state
      t.string :tags

      t.timestamps
    end

    add_reference :users, :user, polymorphic: true
  end
end
