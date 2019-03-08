class Strategy::Items::Filter < AStrategy

  def process

    accountant = driver

    bucket[:items] = Item.where(accountant: accountant)

    true

  end

end