class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account
  has_one :transfer

  def value=(v)

    v = v.gsub(',', '.').to_f if v.is_a? String

    super(v)
  end
end
