class UpdateDecimalToCentsValue < ActiveRecord::Migration[5.2]
  def change
    Transaction.all.each do |transaction|
      transaction.set_price
      transaction.save!
    end
  end
end
