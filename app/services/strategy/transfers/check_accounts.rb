class Strategy::Transfers::CheckAccounts < AStrategy

  def process

    transfer = entity

    origin_transaction = transfer.origin_transaction
    destiny_transaction = transfer.destiny_transaction

    if destiny_transaction and (origin_transaction.account.id == destiny_transaction.account.id)
      add_message 'Não é possível referenciar uma transação de uma conta para a mesma conata'
      set_status :red
      return false
    end

    true

  end
end