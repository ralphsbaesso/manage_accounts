class Strategy::BankStatements::CheckTransactionInDatabase < AStrategy

  def process

    bank_statement = entity
    transactions = bank_statement.transactions
    account = bank_statement.account

    max = transactions.max_by { |t| t.date_transaction }.date_transaction
    min = transactions.min_by { |t| t.date_transaction }.date_transaction

    transactions_from_db = Transaction.where(date_transaction: (min..max), account: account)

    transactions_from_db.each do |t_from_db|
      transactions.delete_if do |transaction|
        t_from_db.date_transaction == transaction.date_transaction and
          t_from_db.description.include? transaction.description.gsub('[', '').gsub(']', '')
      end
    end

    true

  end
end