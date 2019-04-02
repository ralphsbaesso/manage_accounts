module Strategy
  module Transfers
    class SetOriginTransaction < AStrategy

      def process

        transfer = entity

        origin_transaction = transfer.origin_transaction
        origin_transaction.origin = true

        true

      end
    end
  end
end