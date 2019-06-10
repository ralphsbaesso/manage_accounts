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

    bucket[:transactions] = Transaction.where(query).order(date_transaction: :desc, price_cents: :desc)

    true

  end

end