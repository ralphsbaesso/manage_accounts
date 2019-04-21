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

require 'rails_helper'

RSpec.describe BankStatement, type: :model do

  context 'instance methods' do
    let!(:accountant) { create(:accountant) }
    let!(:facade) { Facade.new(accountant) }

    context 'account itau_cc' do
      let!(:account) { create(:account, accountant: accountant, name: 'itau_cc') }

      it 'save 35 transaction' do
        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'extrato_mar2019.txt')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(35)
        expect(bs.transactions.sample).to a_kind_of(Transaction)
        transfer = bs.transactions.sample.transfer
        expect(transfer).to_not be_nil

      end

      it 'save 33 transaction' do
        create(:transaction,
          date_transaction: Date.parse('2019-03-29'),
          description: '[RSHOP-SHIBATA H 0-29/03]',
          price_cents: -14202,
          account: account
        )
        create(:transaction,
          date_transaction: Date.parse('2019-03-29'),
          description: '[RSHOP-ASSAI ATACA-29/03]',
          price_cents: -13921,
          account: account
        )

        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'extrato_mar2019.txt')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(33)
        expect(bs.transactions.sample).to a_kind_of(Transaction)

      end
    end

  end

end
