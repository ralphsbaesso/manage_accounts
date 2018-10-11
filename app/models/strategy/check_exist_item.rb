class CheckExistItem < AStrategy

  def self.process(transporter)

    item = transporter.entity

    items = Item.where(name: item.name)

    if items.present?
      transporter.messages << 'nome já existe na base de dados'
      transporter.status = 'RED'
      return false
    else
      return true
    end
  end

end