module SharedHelper

  def format_date(value, options={})

    value.strftime('%d/%m/%y') if value
  end
end