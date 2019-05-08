class Strategy::BankStatements::FileToTransfers < AStrategy

  def process

    bank_statement = entity

    args = {
      account: bank_statement.account,
      pay_date: bank_statement.pay_date,
      file: bank_statement.last_extract.download,
    }

    read = ReadFile::Factory.build(bank_statement.account.name)
    transactions = read.file_to_transactions(args)

    if transactions.present?
      bank_statement.transactions = transactions
      true
    else
      add_message('Não foi possível recuperar nenhuma informação deste arquivo')
      set_status :red
    end

  rescue CreditCardError => e
    add_message(e.message)
    set_status :red
  rescue => e
    puts e.message
    puts e.backtrace
    add_message('Erro ao ler o arquivo')
    set_status :red
  end
end