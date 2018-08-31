class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false, uniq: true
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
