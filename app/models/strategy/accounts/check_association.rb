module Strategy
  module Accounts
    class CheckAssociation < AStrategy

      def process


        if entity.transactions.count > 0
          add_message 'Conta com transação.'
          set_status 'YELLOW'
        end

        true
      end
    end
  end
end