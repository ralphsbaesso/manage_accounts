class ReadFile::Itau < AReadFile

  def description
    'Responsável por transformar extrato no formato "csv" da conta corrente do Itau para objeto Transfer'
  end

  def file_to_transactions(args)

    account = args[:account]
    file = args[:file]

    transactions = []
    file.split("\n").each do |line|
      csv = line.strip.split(';')
      transaction = Transaction.new
      transaction.date_transaction = DateTime.strptime(csv[0], "%d/%m/%Y")
      transaction.description = "[#{csv[1]}]"
      transaction.price = csv[2]
      transaction.input = :upload
      transaction.account = account
      transaction.amount = 1
      transaction.origin = true
      transactions << transaction
    end
    transactions
  end
end
