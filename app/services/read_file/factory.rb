class ReadFile::Factory
  class << self
    def build(name_account)
      if name_account == 'itau_cc' or name_account == 'Itaú CC'
        ReadFile::Itau.new
      elsif name_account.downcase == 'santander cartão de crédito'
        ReadFile::CartaoCreditoSantander.new
      end
    end
  end
end