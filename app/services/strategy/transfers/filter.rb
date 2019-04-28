class Strategy::Transfers::Filter < AStrategy

  def process

    return true if bucket[:specific_filter]

    filter = bucket[:filter] || {}
    accountant = driver

    query = { account_id: accountant.account_ids }


    start_date = filter[:start_date] || -Date::Infinity.new
    end_date = filter[:end_date] || Date::Infinity.new

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
      bucket[:transactions] = Transaction.where(query).order(date_transaction: :desc)
    end

    true

  end

  private

  def format_pie_chart(transactions)

    item_value_hash = {}
    transactions.each do |transaction|

      name = transaction.subitem.try(:item).try(:name) || 'Item não informado'
      if item_value_hash[name]
        item_value_hash[name] += transaction.price_cents
      else
        item_value_hash[name] = transaction.price_cents
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