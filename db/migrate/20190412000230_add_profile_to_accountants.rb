class AddProfileToAccountants < ActiveRecord::Migration[5.2]
  def change
    add_column :accountants, :profile, :string
  end
end
