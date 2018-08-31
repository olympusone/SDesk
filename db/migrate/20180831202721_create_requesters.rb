class CreateRequesters < ActiveRecord::Migration[5.2]
  def change
    create_table :requesters do |t|
      t.string :name, null: false
      t.string :lastname, null: false
      t.references :company

      t.timestamps
    end
  end
end
