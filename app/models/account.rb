# == Schema Information
#
# Table name: accounts
#
#  id                  :bigint(8)        not null, primary key
#  description         :string
#  header_file         :string
#  ignore_descriptions :text             default("")
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  accountant_id       :bigint(8)
#
# Indexes
#
#  index_accounts_on_accountant_id  (accountant_id)
#

class Account < ApplicationRecord

  has_many :transactions
  has_many :closed_months
  belongs_to :accountant

  monetize :total_balance_cents

  def total_balance_cents
    last = self.closed_months.try(:last)
    last ? last.price_cents : 0
  end

  def ignores
    list = ignore_descriptions.split ';'
    list.map { |description| description.strip.downcase }
  end

end
