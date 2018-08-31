class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.string :title, null: false, uniq: true
      t.text :content
      t.string :tags
      t.references :solution_folder

      t.timestamps
    end
  end
end
