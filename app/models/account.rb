# == Schema Information
#
# Table name: accounts
#
#  id            :bigint(8)        not null, primary key
#  description   :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accountant_id :bigint(8)
#
# Indexes
#
#  index_accounts_on_accountant_id  (accountant_id)
#

class Account < ApplicationRecord

  has_many :transactions

  belongs_to :accountant

end
