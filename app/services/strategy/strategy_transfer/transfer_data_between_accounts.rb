module Strategy
  module StrategyTransfer
    class TransferDataBetweenAccounts < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer

          origin = transfer.origin_transaction
          destiny = transfer.destiny_transaction

          if destiny

            begin
              destiny.value = (origin.value * - 1)
              destiny.date_transaction = origin.date_transaction
              destiny.amount = origin.amount
              destiny.description = origin.description
              destiny.title = origin.title
              destiny.subitem = origin.subitem
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