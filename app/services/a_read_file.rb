class AReadFile

  def description
    raise 'Must implement this method'
  end

  def file_to_transactions
    raise 'Must implement this method'
  end

  private

  def remove_special_charactes(value)
    value.gsub(/^"/, '').gsub(/"$/, '')
  end
end