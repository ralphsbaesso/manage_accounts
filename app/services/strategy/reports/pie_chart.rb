class Strategy::Reports::PieChart < AStrategy

  def process

    return true unless bucket[:pie_chart].present?

    bucket[:data] = format_pie_chart(bucket[:transactions])

    true

  end

  private

  def format_pie_chart(transactions)

    item_value_hash = {}
    transactions.valids.each do |transaction|

      name = transaction.subitem.try(:item).try(:name) || 'Item não informado'
      if item_value_hash[name]
        item_value_hash[name] += transaction.price_cents
      else
        item_value_hash[name] = transaction.price_cents
      end

    end

    # separa positivo e negativo
    positives = []
    negatives = []

    item_value_hash.each do |k, v|
      if v < 0
        negatives << [k, (v * -1)]
      else
        positives << [k, v]
      end

    end

    data = {
        positives: positives,
        negatives: negatives
    }
    data
  end
end