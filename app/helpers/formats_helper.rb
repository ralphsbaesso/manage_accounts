module FormatsHelper

  def format_currency(value)
    Money.new(value.to_s.gsub('.', '').gsub(',', '')).format
  end
end
