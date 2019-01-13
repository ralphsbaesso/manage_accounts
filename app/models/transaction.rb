class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account

  def value=(v)

    v = v.gsub(',', '.').to_f if v.is_a? String

    super(v)
  end

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
end
