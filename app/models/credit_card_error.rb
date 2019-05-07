class CreditCardError < StandardError
  def initialize
    super('Para contas do tipo "Cartão de Crédito" é obrigatório passar a data de pagamento!')
  end
end