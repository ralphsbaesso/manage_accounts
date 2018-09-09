class Transaction < ApplicationRecord

  belongs_to :subitem, optional: true
  belongs_to :account
  belongs_to :transfer, optional: true
end
