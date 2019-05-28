class Strategy::Reports::LineChart < AStrategy

  def process

    return true unless bucket[:line_chart].present?
    accountant = driver

    closed_months  = []
    accountant.accounts.each do |account|
      closed_months += account.closed_months
    end
    # bucket[:data] = format_line_chart(closed_months)

    send("#{entity}_line_chart")

    true

  end

  private

  def account_line_chart
    accountant = driver

    closed_months  = []
    accountant.accounts.each do |account|
      closed_months += account.closed_months
    end

    dates = closed_months.map(&:reference).uniq
    dates.sort!
    accounts = Set.new(closed_months.map(&:account))
    hash_accounts = {}
    accounts.each_with_index { |account, index| hash_accounts[account] = index }

    rows = [['Days'] + hash_accounts.keys.map { |account| account.name }]

    dates.each do |date|
      row = Array.new(hash_accounts.length)

      closed_months.each do |cm|
        if cm.reference == date
          row[hash_accounts[cm.account]] = cm.price_cents
        end
      end

      row.unshift(date)
      rows << row
    end

    bucket[:data] = rows
  end

  def transaction_line_chart(transactions)
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    p transactions

  end
end