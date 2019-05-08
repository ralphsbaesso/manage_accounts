# == Schema Information
#
# Table name: transactions
#
#  id               :bigint(8)        not null, primary key
#  amount           :decimal(, )
#  date_transaction :date
#  description      :string
#  input            :string
#  origin           :boolean
#  price_cents      :integer
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint(8)
#  subitem_id       :bigint(8)
#
# Indexes
#
#  index_transactions_on_account_id  (account_id)
#  index_transactions_on_subitem_id  (subitem_id)
#

class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account

  monetize :price_cents

  def origin?
    self.origin
  end

  def transfer
    Transfer.where(
       'origin_transaction_id = :id OR ' +
       'destiny_transaction_id = :id ', id: self.id
    ).first
  end

  def associated_transaction

    Transaction.joins(
        'join transfers on transfers.origin_transaction_id = transactions.id or transfers.destiny_transaction_id = transactions.id '
    ).where(
        'transfers.destiny_transaction_id is not null ' +
        'and transactions.id <> :id ' +
        'and transfers.id = :transfer_id ',
        id: self.id, transfer_id: self.transfer.id
    ).first
  end

  def set_price
    if value and !price
      self.price = value
    end
  end
end
