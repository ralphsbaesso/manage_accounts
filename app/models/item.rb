# == Schema Information
#
# Table name: items
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
#  index_items_on_accountant_id  (accountant_id)
#

class Item < ApplicationRecord
  extend RuleMap

  belongs_to :accountant
  has_many :subitems

  rules_of_insert [
    Strategy::Items::CheckName,
    Strategy::SaveEntity,
  ]

  rules_of_update [
    Strategy::Items::CheckName,
    Strategy::SaveEntity,
  ]

  rules_of_destroy [
    Strategy::Items::CheckAssociation,
    Strategy::DestroyEntity,
  ]

  rules_of_list [
    Strategy::Items::Filter
  ]
end
