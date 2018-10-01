class Addcols < ActiveRecord::Migration[5.2]
  def change
    add_column :requesters, :title, :string
    add_column :requesters, :notes, :text
    add_column :companies, :domain, :string
    add_column :companies, :notes, :text
  end
end
