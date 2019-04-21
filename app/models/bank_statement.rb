# == Schema Information
#
# Table name: bank_statements
#
#  id            :bigint(8)        not null, primary key
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

class BankStatement < ApplicationRecord
  belongs_to :accountant
  belongs_to :account
  has_many_attached :extracts
  has_one_attached :last_extract

  attr_accessor :transactions

  def last_extract_path
    ActiveStorage::Blob.service.send(:path_for, last_extract.key)
  end

  def transactions
    @transactions ||= []
  end

end
