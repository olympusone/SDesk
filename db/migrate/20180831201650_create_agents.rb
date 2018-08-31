class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :lastname
      t.references :department

      t.timestamps
    end
  end
end
