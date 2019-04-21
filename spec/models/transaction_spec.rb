# == Schema Information
#
# Table name: transactions
#
#  id               :bigint(8)        not null, primary key
#  amount           :decimal(, )
#  date_transaction :date
#  description      :string
#  input            :string
#  origin           :boolean
#  price_cents      :integer
#  title            :string
#  value            :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint(8)
#  subitem_id       :bigint(8)
#
# Indexes
#
#  index_transactions_on_account_id  (account_id)
#  index_transactions_on_subitem_id  (subitem_id)
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:date_transaction) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:origin) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:value) }
  end

end
