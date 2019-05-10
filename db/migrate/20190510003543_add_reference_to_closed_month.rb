class AddReferenceToClosedMonth < ActiveRecord::Migration[5.2]
  def change
    add_column :closed_months, :reference, :date, null: false
  end
end
