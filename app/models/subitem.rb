# == Schema Information
#
# Table name: subitems
#
#  id           :bigint(8)        not null, primary key
#  account_type :string
#  description  :string
#  level        :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint(8)
#
# Indexes
#
#  index_subitems_on_item_id  (item_id)
#

class Subitem < ApplicationRecord
  extend RuleMap

  belongs_to :item

  rules_of_insert [
    Strategy::Subitems::CheckName,
    Strategy::SaveEntity,
  ]

  rules_of_update [
    Strategy::Subitems::CheckName,
    Strategy::SaveEntity,
  ]

  rules_of_destroy [
    Strategy::Subitems::CheckExistAssociationToSubitem,
    Strategy::DestroyEntity,
  ]

  rules_of_list [
    Strategy::Subitems::Filter,
  ]
end
