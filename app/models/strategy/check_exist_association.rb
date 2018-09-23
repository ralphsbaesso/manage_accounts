class CheckExistAssociation < AStrategy

  def self.process(transporter)

    item = transporter.entity
    puts 'item' + item.inspect
    accountant = Accountant.joins(:items).where('items.id' => item.id)

    if accountant.present?
      transporter.messages << 'Esse item está associado a um CORRENTISTA, por tanto não poderá ser apagado!'
      transporter.status = 'RED'
    end


    subitem = Subitem.joins(:item).where('items.id': item)

    if subitem.present?
      transporter.messages << 'Esse item está associado a um SUBITEM, por tanto não poderá ser apagado!'
      transporter.status = 'RED'
    end

    if transporter.messages.present?
      return false
    else
      return true
    end
  end

end