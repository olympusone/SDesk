class CreateSolutionFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :solution_folders do |t|
      t.string :name, null: false, uniq: true
      t.text :description
      t.references :solution_category
      t.timestamps
    end
  end
end
