class CreateBankStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_statements do |t|
      t.references :accountant, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
