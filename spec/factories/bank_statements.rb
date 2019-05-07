# == Schema Information
#
# Table name: bank_statements
#
#  id            :bigint(8)        not null, primary key
#  pay_date      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint(8)
#  accountant_id :bigint(8)
#
# Indexes
#
#  index_bank_statements_on_account_id     (account_id)
#  index_bank_statements_on_accountant_id  (accountant_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (accountant_id => accountants.id)
#

FactoryBot.define do
  factory :bank_statement do
    skip_create
    accountant { nil }
    account { nil }
  end
end
