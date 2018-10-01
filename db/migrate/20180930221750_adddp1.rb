class Adddp1 < ActiveRecord::Migration[5.2]
  def change
    add_reference :ticket_templates, :department
    add_reference :ticket_templates, :agent
  end
end
