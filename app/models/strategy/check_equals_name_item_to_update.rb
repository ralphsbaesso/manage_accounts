class CheckEqualsNameItemToUpdate < AStrategy

  def self.process(transporter)

    item = transporter.entity

    item_from_db = Item.find(item.id)

    if item.name == item_from_db.name
      # nome continua igual, nao eh necessario fazer validacao
      item.save
      return true
    else

      items = Item.where(name: item.name)

      if items.present?
        transporter.messages << 'Nome já existe na base de dados, tente outro'
        transporter.status = 'RED'
        return false
      end
    end
  end

end