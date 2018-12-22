class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account
  has_one :transfer
end
