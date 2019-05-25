# == Schema Information
#
# Table name: bank_statements
#
#  id            :bigint(8)        not null, primary key
#  pay_date      :date
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

  let!(:accountant) { create(:accountant) }
  let!(:facade) { Facade.new(accountant) }

  context 'instance methods' do

    context 'account itau_cc' do
      let!(:account) { create(:account, accountant: accountant, header_file: :date_description_value) }

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

    context 'account "cartão de crédito santander"' do
      let!(:account) { create(:account, accountant: accountant, header_file: :date_description_ignore_value) }

      it 'save 35 transaction' do

        bs = create(:bank_statement, accountant: accountant, account: account, pay_date: Date.today)
        path = File.join(Rails.root, 'spec', 'files', 'cartao_de_credito_santander.csv')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(18)
        expect(bs.transactions.sample).to a_kind_of(Transaction)
        transfer = bs.transactions.sample.transfer
        expect(transfer).to_not be_nil

      end

      it 'save 33 transaction' do

        day = Date.today

        create(:transaction,
               date_transaction: day,
               description: 'LOJAS AMERICANAS MOG(05/08)',
               price_cents: 1817,
               account: account
        )
        create(:transaction,
               date_transaction: day,
               description: 'PERNAMBUCANAS',
               price_cents: 4996,
               account: account
        )

        bs = create(:bank_statement, accountant: accountant, account: account, pay_date: day)
        path = File.join(Rails.root, 'spec', 'files', 'cartao_de_credito_santander.csv')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(16)
        expect(bs.transactions.sample).to a_kind_of(Transaction)

      end
    end

    context 'account inter' do
      let!(:account) { create(:account, accountant: accountant, header_file: :date_description_value) }

      it 'save 35 transaction' do
        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'inter.csv')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(32)
        expect(bs.transactions.sample).to a_kind_of(Transaction)
        transfer = bs.transactions.sample.transfer
        expect(transfer).to_not be_nil

      end

      it 'save 33 transaction' do
        create(:transaction,
               date_transaction: Date.parse('2019-04-22'),
               description: '[COMPRA CARTAO - COMPRA no estabelecimento DEIA MELO REST E PIZZA M]',
               price_cents: -2400,
               account: account
        )
        create(:transaction,
               date_transaction: Date.parse('2019-05-03'),
               description: '[COMPRA CARTAO - COMPRA no estabelecimento SHIBATA H 02           M]',
               price_cents: -12672,
               account: account
        )

        # cria um mes fechado para simular que ja exite para o mes de janeiro
        create(:closed_month, account: account, reference: Date.parse('2019-01-01'))

        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'inter.csv')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(30)
        expect(bs.transactions.sample).to a_kind_of(Transaction)
        expect(bs.account.closed_months.count).to eq(3)
        expect(bs.account.closed_months[0].price.to_f).to eq(123.52)
        expect(bs.account.closed_months[1].price.to_f).to eq(508.87)
        expect(bs.account.closed_months[2].price.to_f).to eq(-300.65)

      end
    end

    context 'ignore_date_doc_description_value_symbol' do
      let!(:account) { create(:account, accountant: accountant, header_file: :ignore_date_doc_description_value_symbol) }

      it 'save 4 transaction' do
        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'ignore_date_doc_description_value_symbol.txt')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)
        expect(bs.transactions.count).to eq(4)
        expect(bs.transactions.sample).to a_kind_of(Transaction)
        transfer = bs.transactions.sample.transfer
        expect(transfer).to_not be_nil

      end
    end

  end



end
