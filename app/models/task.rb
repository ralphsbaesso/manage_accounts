# == Schema Information
#
# Table name: tasks
#
#  id            :bigint(8)        not null, primary key
#  description   :string
#  done          :boolean          default(FALSE)
#  due_date      :date
#  name          :string
#  task_type     :string
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
  extend RuleMap
  
  belongs_to :accountant

  rules_of_insert [
    Strategy::SaveEntity,
  ]

  rules_of_destroy [
    Strategy::DestroyEntity,
  ]

  rules_of_update [
    Strategy::SaveEntity,
  ]
  
  rules_of_list [
    Strategy::Tasks::Filter,
  ]
  
end
