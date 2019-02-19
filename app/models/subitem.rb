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

  belongs_to :item
end
