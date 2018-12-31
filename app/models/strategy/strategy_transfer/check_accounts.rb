module Strategy
  module StrategyTransfer
    class CheckAccounts < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer

          origin_transaction = transfer.origin_transaction
          destiny_transaction = transfer.destiny_transaction

          if destiny_transaction and (origin_transaction.account.id == destiny_transaction.account.id)
            transporter.messages << 'Não é possível referenciar uma transação de uma conta para a mesma conata'
            transporter.status = 'RED'
            return false
          end

          return true

        end

      end
    end
  end
end