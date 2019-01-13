module Strategy
  module StrategyTransfer
    class CheckDisassociate < AStrategy

      def self.process(transporter)

        transfer = transporter.entity

        if transfer.is_a? Transfer and transporter.status == 'GREEN'

          origin = transporter.map[:current_transaction]

          # checar se a transação a ser modificada é destino e está tentando apagar a transação origem
          if origin.origin? == false
            transporter.add_message 'Não é possível alteração uma transação a partir da transação destino!'
            transporter.status = 'RED'
            return false
          end

        end

        true

      end
    end
  end
end