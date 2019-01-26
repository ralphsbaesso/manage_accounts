module Strategy
  class CheckExistEntity < AStrategy

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

      items = Item.where(name: item.name, accountant_id: item.accountant_id)

      if items.present?
        transporter.messages << 'nome já existe na base de dados'
        transporter.status = 'RED'
        return false
      else
        return true
      end

    end

    def self.check_account(account, transporter)

      account = Account.where(name: account.name, accountant_id: account.accountant_id)

      if account.present?
        transporter.messages << 'nome já existe na base de dados'
        transporter.status = 'RED'
        return false
      else
        return true
      end

    end

    def self.check_subitem(subitem, transporter)

      accountant_id = transporter.bucket[:accountant_id]
      item_id = subitem.item_id

      sql = "select subitems.* from subitems " +
        "join items on subitems.item_id = items.id " +
        "join accountants on items.accountant_id = accountants.id " +
        "where accountants.id = ? and items.id = ? and subitems.name = ? "

      subitems = Subitem.find_by_sql [sql, accountant_id, item_id, subitem.name]

      if subitems.present?
        transporter.messages << 'nome já existe na base de dados'
        transporter.status = 'RED'
        return false
      else
        return true
      end

    end

  end
end