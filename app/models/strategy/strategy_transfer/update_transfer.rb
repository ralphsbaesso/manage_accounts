module Strategy
  module StrategyTransfer
    class UpdateTransfer < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer and transporter.status == 'GREEN'

          transfer.save!

          origin = transfer.origin_transaction
          destiny = transfer.destiny_transaction

          origin.save!

          destiny_id = transporter.bucket[:delete_destiny]
          if destiny_id.present?
            Transaction.destroy destiny_id
          else
            destiny.save! if destiny
          end
        end

        true

      end
    end
  end
end