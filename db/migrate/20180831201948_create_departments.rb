class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name, null: false, uniq: true
      t.text :description

      t.timestamps
    end
  end
end
