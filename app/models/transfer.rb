class Transfer < ApplicationRecord

  belongs_to :origin_transaction, class_name: 'Transaction', foreign_key: :origin_transaction_id, autosave: true
  belongs_to :destiny_transaction, class_name: 'Transaction', foreign_key: :destiny_transaction_id, autosave: true, optional: true

  after_destroy :destroy_transactions

  def destroy_transactions
    origin_transaction = self.origin_transaction
    destiny_transaction = self.destiny_transaction

    origin_transaction.destroy!
    destiny_transaction.destroy! if destiny_transaction

  end
end
