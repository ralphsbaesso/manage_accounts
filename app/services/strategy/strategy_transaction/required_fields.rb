class Strategy::StrategyTransaction::RequiredFields < AStrategy

  def process

  t = entity

    errors = []

    if t.date_transaction.present?
      begin
        t.date_transaction = t.date_transaction.to_date
      rescue
        errors << 'Formato da data de transação incorreto'
      end
    else
      errors << 'Data da transação é obrigatória'
    end

    errors << 'Valor da transação é obrigatório' unless t.value.present?
    t.amount = 1 if !t.amount.present? or t.amount < 1 # quantidade não informada, atribui 1

    if errors.present?
      set_status :red
      add_message errors
      return false
    end
  end

  true

end