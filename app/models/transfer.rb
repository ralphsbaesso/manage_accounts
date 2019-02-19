# == Schema Information
#
# Table name: transfers
#
#  id                     :bigint(8)        not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  destiny_transaction_id :bigint(8)
#  origin_transaction_id  :bigint(8)
#
# Indexes
#
#  index_transfers_on_destiny_transaction_id  (destiny_transaction_id)
#  index_transfers_on_origin_transaction_id   (origin_transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (destiny_transaction_id => transactions.id)
#  fk_rails_...  (origin_transaction_id => transactions.id)
#

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
