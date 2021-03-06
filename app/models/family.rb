# == Schema Information
#
# Table name: families
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ApplicationRecord
  has_many :accountants, autosave: true
end
