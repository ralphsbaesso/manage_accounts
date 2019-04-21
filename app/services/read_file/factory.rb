class ReadFile::Factory
  class << self
    def build(name_account)
      if name_account == 'itau_cc' or name_account == 'Itaú CC'
        return ReadFile::Itau.new
      end
    end
  end
end