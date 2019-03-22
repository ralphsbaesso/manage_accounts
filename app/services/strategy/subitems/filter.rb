class Strategy::Subitems::Filter < AStrategy

  def process

    accountant = driver

    items = accountant.items

    bucket[:subitems] = Subitem.where(item_id: items.map { |item| item.id })

    true

  end

end