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

require 'rails_helper'

RSpec.describe Role, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
