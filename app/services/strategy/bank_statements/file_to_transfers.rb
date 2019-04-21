class Strategy::BankStatements::FileToTransfers < AStrategy

  def process

    bank_statement = entity
    account = bank_statement.account

    read = ReadFile::Factory.build(bank_statement.account.name)
    transactions = read.file_to_transactions(bank_statement.last_extract.download, account)

    if transactions.present?
      bank_statement.transactions = transactions
    else
      add_message('Não foi possível recuperar nenhuma informação deste arquivo')
      set_status :red
    end

    true

  rescue
    add_message('Erro ao ler o arquivo')
    set_status :red
    return false
  end
end