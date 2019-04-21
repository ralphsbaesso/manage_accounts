class Strategy::BankStatements::SaveTransactions < AStrategy

  def process

    bank_statement = entity
    transactions = bank_statement.transactions

    transactions.each do |transaction|
      transfer = Transfer.new
      transfer.origin_transaction = transaction
      transfer.save!
    end

    true

  end
end