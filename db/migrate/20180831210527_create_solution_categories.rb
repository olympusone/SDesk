class CreateSolutionCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :solution_categories do |t|
      t.string :name, null: false, uniq: true
      t.text :description

      t.timestamps
    end
  end
end
