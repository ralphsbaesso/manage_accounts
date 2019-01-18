class AddOwnerToAccountant < ActiveRecord::Migration[5.2]
  def change
    add_column :accountants, :owner, :boolean, default: false
  end
end
