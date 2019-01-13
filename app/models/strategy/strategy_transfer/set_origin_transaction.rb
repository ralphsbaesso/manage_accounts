module Strategy
  module StrategyTransfer
    class SetOriginTransaction < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer

          origin_transaction = transfer.origin_transaction
          origin_transaction.origin = true

        end

        true

      end
    end
  end
end