# == Schema Information
#
# Table name: closed_months
#
#  id          :bigint(8)        not null, primary key
#  price_cents :integer
#  reference   :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint(8)
#
# Indexes
#
#  index_closed_months_on_account_id  (account_id)
#

class ClosedMonth < ApplicationRecord
  belongs_to :account

  monetize :price_cents

end
