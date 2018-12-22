module Strategy
  class CheckExistEntity < AStrategy

    def self.process(transporter)



      entity = transporter.entity

      if entity.is_a? Item
        check_item(entity)
      elsif entity.is_a? Account
        check_account(entity)
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

    def self.check_account(account)

      account = Account.where(name: account.name, accountant_id: account.accountant_id)

      if account.present?
        transporter.messages << 'nome já existe na base de dados'
        transporter.status = 'RED'
        return false
      else
        return true
      end

    end
  end
end