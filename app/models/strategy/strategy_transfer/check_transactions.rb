class Strategy::StrategyTransfer::CheckTransactions

  def self.process(transporter)

    transfer = transporter.entity

    if transfer.is_a? Transfer

      origin_transaction = transfer.origin_transaction

      messages = []
      if origin_transaction
        t = Transporter.new(transporter.current_accountant)
        t.entity = origin_transaction
        Strategy::StrategyTransaction::RequiredFields.process(t)
        messages += t.messages
      end

      if messages.present?
        transporter.messages += messages
        transporter.status = 'RED'
        return false
      end

    end

    true

  end
end