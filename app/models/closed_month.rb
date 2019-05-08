class ClosedMonth < ApplicationRecord
  belongs_to :account

  monetize :price_cents

end
