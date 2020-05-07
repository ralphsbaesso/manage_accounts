class Strategy::Reports::PieChart < AStrategy

  def process

    return true unless bucket[:pie_chart].present?

    bucket[:data] = format_pie_chart(bucket[:transactions])

    true

  end

  private

  def format_pie_chart(transactions)

    item_value_hash = {}
    item_negative_value_hash = {}
    transactions.valids.each do |transaction|

      name = transaction.subitem.try(:item).try(:name) || 'Item não informado'
      if transaction.price_cents >= 0
        if item_value_hash[name]
          item_value_hash[name] += transaction.price_cents
        else
          item_value_hash[name] = transaction.price_cents
        end
      else
        if item_negative_value_hash[name]
          item_negative_value_hash[name] += transaction.price_cents
        else
          item_negative_value_hash[name] = transaction.price_cents
        end
      end

    end

    # separa positivo e negativo
    negatives = item_negative_value_hash.map { |k, v| [k, (v * -1)] }
    positives = item_value_hash.map { |k, v| [k, v] }

    data = {
        positives: positives,
        negatives: negatives
    }
    data
  end
end