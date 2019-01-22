module Strategy
  module StrategyTransfer
    class SetAttributesTransactions < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer

          origin_transaction = transfer.origin_transaction
          destiny_transaction = transfer.destiny_transaction

          transporter.map[:attributes_orgin].each do |key, value|
            origin_transaction[key] = value if origin_transaction.has_attribute? key
          end


          if destiny_transaction and transporter.map[:attributes_destiny].present?
            transporter.map[:attributes_destiny].each do |key, value|
              destiny_transaction[key] = value if destiny_transaction.has_attribute? key
            end
          elsif transporter.map[:attributes_destiny].present? # nao ha destiny
            transfer.destiny_transaction = Transaction.new(transporter.map[:attributes_destiny])
          else
            transporter.map[:delete_destiny] = destiny_transaction.id if destiny_transaction
            transfer.destiny_transaction = nil
          end

        end

        true
      end
    end
  end
end