module Strategy
  class CheckEqualsNameEntityToUpdate < AStrategy

    def self.process(transporter)

      entity = transporter.entity

      if entity.is_a? Item
        check_item(entity, transporter)
      elsif entity.is_a? Account
        check_account(entity, transporter)
      elsif entity.is_a? Subitem
        check_subitem(entity, transporter)
      end

    end

  private

    def self.check_item(item, transporter)

      attributes = transporter.bucket[:attributes]
      item_from_db = Item.find(item.id)

      if attributes[:name] == item_from_db.name
        # nome continua igual, nao eh necessario fazer validacao
        item.update(attributes)
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

    def self.check_subitem(subitem, transporter)

      attributes = transporter.bucket[:attributes]
      subitem_from_db = Subitem.find(subitem.id)

      if attributes[:name] == subitem_from_db.name
        # nome continua igual, nao eh necessario fazer validacao
        subitem.update(attributes)
        return true
      else

        items = Item.where(name: subitem.name)

        if items.present?
          transporter.messages << 'Nome já existe na base de dados, tente outro'
          transporter.status = 'RED'
          return false
        end
      end
    end

    def self.check_account(account, transporter)

      attributes = transporter.bucket[:attributes]
      account_from_db = Account.find(account.id)

      if attributes[:name] == account_from_db.name
        # nome continua igual, nao eh necessario fazer validacao
        account.update(attributes)
        return true
      else

        items = Item.where(name: account.name)

        if items.present?
          transporter.messages << 'Nome já existe na base de dados, tente outro'
          transporter.status = 'RED'
          return false
        end
      end
    end

  end
end