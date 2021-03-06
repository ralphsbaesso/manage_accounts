class Strategy::Transfers::CheckDisassociate < AStrategy

  def process

    current_transaction = bucket[:current_transaction]

    # checar se a transação a ser modificada é destino e está tentando apagar a transação origem
    if current_transaction.origin? == false
      add_message 'Não é possível alteração uma transação a partir da transação destino!'
      set_status :red
      return false
    end

    true
  end

end