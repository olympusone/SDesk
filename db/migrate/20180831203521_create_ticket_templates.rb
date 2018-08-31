class CreateTicketTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_templates do |t|
      t.string :name, null: false, uniq: true
      t.boolean :active, default: false
      t.string :subject, null: false
      t.text :description
      t.integer :priority
      t.integer :state
      t.string :tags

      t.timestamps
    end

    add_reference :tickets, :department

  end
end
