class Strategy::Subitems::CheckName < AStrategy

  def process

    accountant = driver
    subitem = entity

    sql = "select subitems.* from subitems " +
        "join items on subitems.item_id = items.id " +
        "join accountants on items.accountant_id = accountants.id " +
        "where accountants.id = ? and items.id = ? and subitems.name = ? "

    subitems = Subitem.find_by_sql([sql, accountant.id, subitem.item_id, subitem.name]).to_a

    if subitems.present?
      add_message 'nome já existe na base de dados'
      set_status :yellow
    end

    true
  end
end