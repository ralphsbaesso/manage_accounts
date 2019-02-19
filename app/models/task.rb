# == Schema Information
#
# Table name: tasks
#
#  id            :bigint(8)        not null, primary key
#  description   :string
#  done          :boolean
#  due_date      :date
#  name          :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accountant_id :bigint(8)
#
# Indexes
#
#  index_tasks_on_accountant_id  (accountant_id)
#
# Foreign Keys
#
#  fk_rails_...  (accountant_id => accountants.id)
#

class Task < ApplicationRecord
  belongs_to :accountant
end
