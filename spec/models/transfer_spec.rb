# == Schema Information
#
# Table name: transfers
#
#  id                     :bigint(8)        not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  destiny_transaction_id :bigint(8)
#  origin_transaction_id  :bigint(8)
#
# Indexes
#
#  index_transfers_on_destiny_transaction_id  (destiny_transaction_id)
#  index_transfers_on_origin_transaction_id   (origin_transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (destiny_transaction_id => transactions.id)
#  fk_rails_...  (origin_transaction_id => transactions.id)
#


require 'rails_helper'

RSpec.describe Transfer, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:destiny_transaction_id) }
    it { is_expected.to respond_to(:origin_transaction_id) }
  end

  let!(:accountant) { create(:accountant) }
  let!(:account) { create(:account, accountant: accountant) }
  let!(:account2) { create(:account, accountant: accountant) }
  let!(:item) { create(:item, accountant: accountant) }
  let!(:subitem) { create(:subitem, item: item) }
  let!(:facade) { Facade.new(accountant) }

  context 'save' do
    it 'increase one tranfer' do
      origin_transaction = build(:transaction, subitem: subitem, account: account)
      transfer = build(:transfer)
      transfer.origin_transaction = origin_transaction
      expect {
        facade.insert(transfer)
      }.to change(Transfer, :count).by(1)
    end

    it 'not save if without value' do
      origin_transaction = build(:transaction, subitem: subitem, account: account, price_cents: nil)
      transfer = build(:transfer)
      transfer.origin_transaction = origin_transaction
      expect {
        transporter = facade.insert(transfer)
        expect(transporter.status_red?).to be true
      }.to change(Transfer, :count).by(0)
    end

    it 'increase two transaction (origin end destiny)' do
      origin_transaction = build(:transaction, subitem: subitem, account: account)
      destiny_transaction = build(:transaction, account: account2)
      transfer = build(:transfer)
      transfer.origin_transaction = origin_transaction
      transfer.destiny_transaction = destiny_transaction
      expect {
        facade.insert(transfer)
      }.to change(Transaction, :count).by(2)
    end
  end

  context 'update' do
    let!(:transaction) { build(:transaction, subitem: subitem, account: account, date_transaction: Date.today) }
    let!(:transfer) { create(:transfer, origin_transaction: transaction) }

    it 'modify attributes' do

      title = Faker::Name.name
      description = Faker::Book.publisher

      facade.update(transfer,
    {
            current_transaction: transaction,
            attributes_orgin: { title: title, description: description }
          }
      )

      transaction_from_db = Transaction.find(transaction.id)
      expect(transaction_from_db.title).to eq(title)
      expect(transaction_from_db.description).to eq(description)
    end

    it 'transfer with one transaction update to transfer two transaction' do

      map = {
          current_transaction: transaction,
      }
      map[:attributes_destiny] = { account_id: account2.id }

      transporter = facade.update transfer, map

      expect(transporter.status_green?).to be true

      t1 = Transaction.first
      t2 = Transaction.last

      expect(t1.transfer).to be_present
      expect(t2.transfer).to be_present


    end

    it 'return message error update with wrong date' do

      transporter = facade.update(transfer,
                    {
                        current_transaction: transaction,
                        attributes_orgin: { date_transaction: nil }
                    }
      )

      expect(transporter.status_red?).to be true
      expect(transporter.messages).to include('Data da transação é obrigatória')
    end
  end

  context 'delete' do
    let!(:transaction) { build(:transaction, subitem: subitem, account: account, date_transaction: Date.today) }
    let!(:transfer) { create(:transfer, origin_transaction: transaction) }
    it 'decrease one item' do
      expect {
        facade.delete(transfer)
      }.to change(Transfer, :count).by(-1)
    end

  end

  context 'select' do

    it 'return list of items' do
      amount = 10

      amount.times do
        transaction = build(:transaction, subitem: subitem, account: account, date_transaction: Date.today)
        create(:transfer, origin_transaction: transaction)
      end

      transporter = facade.select :transfer
      expect(transporter.bucket[:transactions].count).to eq(amount)
    end
  end

end
