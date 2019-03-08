module Strategy
  module Accounts
    class CheckName < AStrategy

      def process

        accountant = driver
        account = entity
        name = account.name

        accounts = Account.where(accountant: accountant, name: name).where.not(id: account.id).to_a

        if accounts
          accounts.each do |account_from_db|
            if account_from_db.name == name
              add_message 'Nome já em uso'
              set_status 'YELLOW'
            end
          end

        end

        true
      end
    end
  end
end