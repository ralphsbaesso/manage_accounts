class Account < ApplicationRecord

  has_many :transactions_bank

  belongs_to :accountant

end
