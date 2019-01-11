module Strategy
  module StrategyTransfer
    class TransferDataBetweenAccounts < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer

          origin_transaction = transfer.origin_transaction
          destiny_transaction = transfer.destiny_transaction

          if destiny_transaction

            begin
              destiny_transaction.value = (origin_transaction.value * - 1)
              destiny_transaction.date_transaction = origin_transaction.date_transaction
            rescue
              return false
            end
          end
        end

        true

      end
    end
  end
end