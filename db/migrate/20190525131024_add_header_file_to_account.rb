class AddHeaderFileToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :header_file, :string
  end
end
