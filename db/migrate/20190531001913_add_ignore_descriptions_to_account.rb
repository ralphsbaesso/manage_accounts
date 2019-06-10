class AddIgnoreDescriptionsToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :ignore_descriptions, :text, default: ''
  end
end
