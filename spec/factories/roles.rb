# == Schema Information
#
# Table name: roles
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
#  index_roles_on_accountant_id  (accountant_id)
#
# Foreign Keys
#
#  fk_rails_...  (accountant_id => accountants.id)
#

FactoryBot.define do
  factory :role do
    name { "MyString" }
    description { "MyString" }
    accountant { nil }
  end
end
