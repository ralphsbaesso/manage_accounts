class Strategy::Transfers::CheckTransactions < AStrategy

  def process

    transfer = entity

    origin_transaction = transfer.origin_transaction

    messages = []
    if origin_transaction
      t = Transporter.new(driver)
      t.entity = origin_transaction
      strategy = Strategy::StrategyTransaction::RequiredFields.new(t)
      strategy.process
      messages += t.messages
    end

    if messages.present?
      add_message messages
      set_status :red
      return false
    end

    true

  end
end