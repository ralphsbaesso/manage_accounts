class Transfer < ApplicationRecord

  belongs_to :origin_transaction, class_name: 'Transaction', foreign_key: :origin_transaction_id, autosave: true
  belongs_to :destiny_transaction, class_name: 'Transaction', foreign_key: :destiny_transaction_id, autosave: true, optional: true
end
