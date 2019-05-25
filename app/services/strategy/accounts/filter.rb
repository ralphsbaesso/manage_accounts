class Strategy::Accounts::Filter < AStrategy

  def process

    return true if bucket[:specific_filter]

    filter = bucket[:filter] || {}
    accountant = driver

    query = { account_id: accountant.account_ids }

    bucket[:accounts] = Account.where(query).order(created_at: :desc)

    true

  end

end