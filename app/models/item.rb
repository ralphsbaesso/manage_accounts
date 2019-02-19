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

  belongs_to :accountant

  has_many :subitems
end
