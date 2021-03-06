class Strategy::Transfers::TransferDataBetweenAccounts < AStrategy

  def process

    transfer = entity

    origin = transfer.origin_transaction
    destiny = transfer.destiny_transaction

    if destiny

      begin
        destiny.price_cents = (origin.price_cents * -1)
        destiny.date_transaction = origin.date_transaction
        destiny.amount = origin.amount
        destiny.description = origin.description
        destiny.title = origin.title
        destiny.subitem = origin.subitem
        destiny.ignore = true
      rescue => e
        set_status :red
        add_message e.message
        return false
      end
    end

    true

  end
end