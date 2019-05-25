class ReadFile::IgnoreDateDocDescriptionValueSymbol < AReadFile

  def description
    '[0] Ignore, [1] Date, [3] Description, [4] Value, [5] Symbol (Positive or Negative)'
  end

  def file_to_transactions(args)

    account = args[:account]
    file = args[:file]

    transactions = []
    file.split("\n").each do |line|
      row = line.strip.split(';').map { |line| remove_special_charactes(line) }
      begin
        transaction = Transaction.new
        transaction.date_transaction = DateTime.strptime(row[1], "%Y%m%d")
        transaction.description = "[#{row[3]}]"
        transaction.price = format_price(row[4], row[5])
        transaction.input = :upload
        transaction.account = account
        transaction.amount = 1
        transaction.origin = true
        transactions << transaction
      rescue => e
        puts e.message
        p row
      end
    end
    transactions
  end

  def format_price(value, symbol)
    symbol = symbol.strip

    value_formated =
      if symbol.downcase.downcase == 'c' or symbol == '+'
        value
      else
        "-#{value}"
      end
    value_formated.gsub('.', ',')
  end
end
