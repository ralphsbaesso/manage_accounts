class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account

  def value=(v)

    v = v.gsub(',', '.').to_f if v.is_a? String

    super(v)
  end

  def transfer
    Transfer.where(
       'origin_transaction_id = :id OR ' +
       'destiny_transaction_id = :id ', id: self.id
    ).first
  end
end
