
namespace :transaction do
  desc "This task does nothing"
  task update_closed_months: :environment do

    Account.all.each do |account|
      start_date = account.transactions.minimum(:date_transaction)
      end_date = account.transactions.maximum(:date_transaction)

      diff = (start_date.year * 12 + start_date.month) - (end_date.year * 12 + end_date.month) + 1

      diff.times do
        _start = start_date.beginning_of_month
        _end = start_date.end_of_month
        transactions = Transaction.where(date_transaction: (_start.._end), account: account)
        total_value = transactions.map { |t| t.price_cents }.sum
        closed_month = ClosedMonth.find_or_create_by(reference: _start, account: account)
        closed_month.price_cents = total_value
        closed_month.save!

        start_date + 1.month
      end
    end
  end
end