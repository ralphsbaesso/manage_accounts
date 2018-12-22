class Transfer < ApplicationRecord

  has_one :origin_transaction, class_name: 'Transaction', foreign_key: :origin_transaction_id
  has_one :destiny_transaction, class_name: 'Transaction', foreign_key: :destiny_transaction_id
end
