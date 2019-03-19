class Strategy::Subitems::CheckExistAssociationToSubitem < AStrategy

  def process

    subitem = entity

    subitems = Transaction.joins(:subitem).where(subitems: { id: subitem.id })

    if subitems.present?
      add_message 'Esse subitem está associado a uma TRANSAÇÃO, por tanto não poderá ser apagado!'
      set_status :red
      return false
    end

    true

  end
end