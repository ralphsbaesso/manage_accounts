class AddPayDateToBankStatement < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_statements, :pay_date, :date, default: nil
  end
end
