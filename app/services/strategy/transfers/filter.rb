class Strategy::Transfers::Filter < AStrategy

  def process

    return true if bucket[:specific_filter]

    filter = bucket[:filter] || {}
    accountant = driver

    query = { account_id: accountant.account_ids }

    date = filter[:date] || Date.today

    start_date = date.beginning_of_month
    end_date = date.end_of_month
    query[:date_transaction] = (start_date..end_date)


    if filter[:subitem_id].present?
      query[:subitem_id] = filter[:subitem_id]
    elsif filter[:item_id].present?
      subitem_ids = Subitem.where(item_id: filter[:item_id]).map { |subitem| subitem.id }
      query[:subitem_id] = subitem_ids
    end

    query[:account_id] = filter[:account_id] if filter[:account_id].present?

    if bucket[:format] == :pie_chart
      bucket[:data] = format_pie_chart(Transaction.where(query))
    else
      bucket[:transactions] = Transaction.where(query).order(:date_transaction).page(filter[:page]).per(filter[:per])
    end

    true

  end

  private

  def self.format_pie_chart(transactions)

    item_value_hash = {}
    transactions.each do |transacotion|

      name = transacotion.subitem.item.name
      if item_value_hash[name]
        item_value_hash[name] += transacotion.value
      else
        item_value_hash[name] = transacotion.value
      end

    end

    # separa positivo e negativo
    positives = [['Item', 'Value']]
    negatives = [['Item', 'Value']]

    item_value_hash.each do |k, v|
      if v < 0
        negatives << [k, (v * -1)]
      else
        positives << [k, v]
      end

    end

    data = {
        positives: positives,
        negatives: negatives
    }
    data
  end
end