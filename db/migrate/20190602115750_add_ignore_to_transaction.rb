class AddIgnoreToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :ignore, :boolean, default: false
  end
end
