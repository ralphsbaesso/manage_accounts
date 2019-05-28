# == Schema Information
#
# Table name: accounts
#
#  id            :bigint(8)        not null, primary key
#  description   :string
#  header_file   :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accountant_id :bigint(8)
#
# Indexes
#
#  index_accounts_on_accountant_id  (accountant_id)
#

require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
  end

  let!(:accountant) { create(:accountant) }
  let!(:facade) { Facade.new(accountant) }

  context 'Save' do
    it 'increase one account' do

      account = create(:account, accountant: accountant)
      facade.insert(account)
      count = Account.count
      expect(count).to eq(1)
    end
  end

  context 'update' do
    let!(:account) { create(:account, accountant: accountant) }

    it 'modify attributes' do
      id = account.id
      name = Faker::Name.name
      description = Faker::Book.publisher
      facade.update account, attributes: { name: name, description: description }

      account_from_db = Account.find(id)
      expect(account_from_db.name).to eq(name)
      expect(account_from_db.description).to eq(description)
    end

    it 'return message error update with same name' do

      other_account = create(:account, accountant: accountant)

      name = other_account.name
      transporter = facade.update(account, attributes: { name: name })

      expect(transporter.status).to eq(:red)
    end
  end

  context 'delete' do
    it 'decrease one account' do

      account = create(:account, accountant: accountant)
      expect {
        facade.delete(account)
      }.to change(Account, :count).by(-1)
    end

    it 'return error account with association' do
      account = create(:account, accountant: accountant)
      item = create(:item, accountant: accountant)
      subitem = create(:subitem, item: item)
      create(:transaction, account: account, subitem: subitem)

      transport = nil
      expect {
        transport = facade.delete(account)
      }.to change(Account, :count).by(0)

      expect(transport.status_red?).to be_truthy
    end
  end

  context 'methods' do
    context '#total_balance' do
      let!(:account) { create(:account, accountant: accountant, header_file: :date_description_value) }

      it 'Must return total balance' do
        bs = create(:bank_statement, accountant: accountant, account: account)
        path = File.join(Rails.root, 'spec', 'files', 'inter.csv')
        bs.last_extract.attach(io: File.open(path), filename: 'test')

        facade.insert(bs)

        account_from_db = Account.find(account.id)
        expect(account_from_db.total_balance.to_f).to eq(331.74)
      end
    end
  end

end
