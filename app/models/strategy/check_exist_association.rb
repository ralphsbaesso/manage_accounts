module Strategy
  class CheckExistAssociation < AStrategy

    def self.process(transporter)

      item = transporter.entity

      subitem = Subitem.joins(:item).where('items.id': item.id)

      if subitem.present?
        transporter.messages << 'Esse item está associado a um SUBITEM, por tanto não poderá ser apagado!'
        transporter.status = 'RED'
        return false
      end

      true

    end
  end
end