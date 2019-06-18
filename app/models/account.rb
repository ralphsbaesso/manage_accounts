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
  extend RuleMap

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

  rules_of_insert [
    Strategy::Accounts::CheckName,
    Strategy::SaveEntity
  ]
  rules_of_update  [
    Strategy::Accounts::CheckName,
    Strategy::SaveEntity
  ]
  rules_of_list [
    Strategy::Accounts::Filter,
    Strategy::Reports::LineChart
  ]
  rules_of_destroy [
    Strategy::Accounts::CheckAssociation,
    Strategy::DestroyEntity
  ]

end
