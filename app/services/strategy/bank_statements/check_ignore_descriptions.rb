class Strategy::BankStatements::CheckIgnoreDescriptions < AStrategy

  def process
    if entity.is_a? BankStatement
      bank_statement = entity
      transactions = bank_statement.transactions
      ignores = bank_statement.account.ignores
    elsif entity.is_a? Transfer
      transfer = entity
      ignores = transfer.origin_transaction.account.ignores
      transactions = [entity.origin_transaction]
    end

    return true unless ignores.present?

    transactions.each do |transaction|
      transaction.ignore = true if ignore_description?(ignores, transaction.description)
    end

    true
  end

  private

  def ignore_description?(ignores, description)
    value = description.gsub('[', '').gsub(']', '').strip.downcase
    ignores.include? value
  end
end