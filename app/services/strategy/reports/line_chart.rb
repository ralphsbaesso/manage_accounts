class Strategy::Reports::LineChart < AStrategy

  def process

    return true unless bucket[:line_chart].present?
    accountant = driver

    closed_months  = []
    accountant.accounts.each do |account|
      closed_months += account.closed_months
    end
    bucket[:data] = format_line_chart(closed_months)

    true

  end

  private

  def format_line_chart(closed_months)

    dates = Set.new(closed_months.map(&:reference))
    accounts = Set.new(closed_months.map(&:account))
    hash_accounts = {}
    accounts.each_with_index { |account, index| hash_accounts[index] = account }

    data = [['Days'] + hash_accounts.values.map { |account| account.name }]

    closed_months.each do |cm|

      value = Array.new(hash_accounts.length + 1)
      value[0] = cm.reference

      hash_accounts.each do |k, v|
        index = k + 1
        if dates.include? cm.reference and cm.account = v
          value[index] = cm.price_cents
        else
          value[index] = 0
        end
      end

      data << value
    end

    data
  end
end