class ReadFile::CartaoCreditoSantander < AReadFile

  def description
    'Responsável por transformar extrato no formato "csv" do cartão de crédito Santander para objeto Transfer'
  end

  def file_to_transactions(args)

    pay_date = args[:pay_date]
    account = args[:account]
    file = args[:file]

    raise CreditCardError.new unless pay_date

    transactions = []
    file.split("\n").each do |line|
      csv = line.strip.split(';')
      next if csv.count != 4
      transaction = Transaction.new
      transaction.date_transaction = pay_date
      transaction.description = "[#{csv[1]}]"
      transaction.price = csv[3]
      transaction.input = :upload
      transaction.account = account
      transaction.amount = 1
      transaction.origin = true
      transactions << transaction
    end
    transactions
  end
end
