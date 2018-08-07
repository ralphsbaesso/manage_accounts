json.extract! transaction, :id, :date_transaction, :value, :description, :title, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
