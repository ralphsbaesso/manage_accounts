module Util
  class Month

    def self.all
      [
        'Janeiro',
        'Fevereiro',
        'Março',
        'Abril',
        'Maio',
        'Junho',
        'Julho',
        'Agosto',
        'Setembro',
        'Outubro',
        'Novembro',
        'Dezembro'
      ]
    end

    def self.current
      index = Date.today.month - 1
      self.all[index]
    end

    def self.number_by_name(name)
      number = self.all.index name
      number + 1
    end

  end

  class Year

    def self.recent(diff = 10)
      year = Date.today.year
      start = year - diff
      final = year + diff
      range = *(start..final)
      range
    end

    def self.current
      Date.today.year
    end

  end
end