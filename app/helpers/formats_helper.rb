module FormatsHelper

  def format_currency(value)
    Money.new(value).format
  end
end
