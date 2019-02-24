module Strategy
  module Items
    class CheckName < AStrategy

      def process

        accountant = driver
        item = entity
        name = item.name

        items = Item.where(accountant: accountant, name: name).where.not(id: item.id)

        items.each do |account_from_db|
          if account_from_db.name == name
            add_message 'Nome já em uso'
            set_status 'YELLOW'
          end
        end

        true
      end
    end
  end
end