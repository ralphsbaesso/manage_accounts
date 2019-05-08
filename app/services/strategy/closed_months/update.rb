class Strategy::ClosedMonths::Update < AStrategy

  def process

    transactions = entity.transactions
    account = entity.account

    dates = []
    transactions.each do |transaction|
      date = "#{transaction.date_transaction.year}-#{transaction.date_transaction.month}-01"
      dates << date unless dates.include? date
    end

    dates.each do |date|
      start_date = Date.parse(date).beginning_of_month
      end_date = Date.parse(date).end_of_month
      transactions_from_db = Transaction.where(date_transaction: (start_date..end_date), account: account)
      total_value = transactions_from_db.map { |t| t.price_cents }.sum
      ClosedMonth.create(price_cents: total_value, account: account)
    end

    true

  end
end