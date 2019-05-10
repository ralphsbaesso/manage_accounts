class Strategy::ClosedMonths::Update < AStrategy

  def process

    if entity.is_a? BankStatement
      update entity.transactions, entity.account_id
    elsif entity.is_a? Transfer
      transactions = []
      transactions << entity.origin_transaction
      transactions << entity.destiny_transaction if entity.destiny_transaction
      update transactions
    end

    true

  end

  private

  def update(transactions, account_id=nil)
    map = {}
    transactions.each do |transaction|
      date = "#{transaction.date_transaction.year}-#{transaction.date_transaction.month}-01"
      account_id = account_id || transaction.account_id
      key = "#{account_id}-#{date}"
      map[key] = [account_id, date] unless map.key? key
    end

    map.each_value do |value|
      account_id = value[0]
      date = value[1]
      start_date = Date.parse(date).beginning_of_month
      end_date = Date.parse(date).end_of_month
      transactions_from_db = Transaction.where(date_transaction: (start_date..end_date), account_id: account_id)
      total_value = transactions_from_db.map { |t| t.price_cents }.sum
      closed_month = ClosedMonth.find_or_create_by(reference: date, account_id: account_id)
      closed_month.price_cents = total_value
      closed_month.save!
    end
  end
end