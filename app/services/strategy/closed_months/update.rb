class Strategy::ClosedMonths::Update < AStrategy

  def process

    if entity.is_a? BankStatement
      transaction = entity.transactions.min_by(&:date_transaction)
      update(entity.account, transaction.date_transaction) if transaction
    elsif entity.is_a? Transfer
      account = entity.origin_transaction.account
      date_transaction = entity.origin_transaction.date_transaction
      update account, date_transaction
    end

    true

  end

  private

  def update(account , init_date)

    end_date = account.transactions.maximum(:date_transaction)
    diff = (end_date.year * 12 + end_date.month) - (init_date.year * 12 + init_date.month) + 1

    date_ago = init_date - 1.month
    date_ago_formated = "#{date_ago.year}-#{date_ago.month}-01"

    last_total_value = ClosedMonth.find_by(account: account, reference: date_ago_formated).try(:price_cents) || 0

    diff.times do |index|
      current_date = init_date + index.month
      date = "#{current_date.year}-#{current_date.month}-01"

      start_date = current_date.beginning_of_month
      end_date = current_date.end_of_month

      transactions_from_db = Transaction.where(date_transaction: (start_date..end_date), account_id: account.id)
      total_value = transactions_from_db.map { |t| t.price_cents }.sum

      closed_month = ClosedMonth.find_or_create_by(reference: date, account_id: account.id)
      closed_month.price_cents = total_value + last_total_value
      last_total_value = total_value + last_total_value
      closed_month.save!
    end
  end

end