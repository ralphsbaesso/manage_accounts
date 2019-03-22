
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

  let!(:accountant) { create(:accountant) }
  let!(:account) { create(:account, accountant: accountant) }
  let!(:item) { create(:item, accountant: accountant) }
  let!(:subitem) { create(:subitem, item: item) }
  let!(:facade) { Facade.new(accountant) }

  context 'Save' do
    it 'increase one item' do

      transaction = build(:transaction, subitem: subitem, account: account)
      expect {
        facade.insert(transaction)
      }.to change(Transaction, :count).by(1)
    end

    it 'not save if name already existing' do
      name = Faker::FunnyName.name
      create(:transaction, item: item, name: name)
      transaction = build(:transaction, item: item, name: name)
      expect {
        facade.insert(transaction)
      }.to change(Transaction, :count).by(0)
    end
  end

  context 'update' do
    let!(:transaction) { create(:transaction, item: item) }

    it 'modify attributes' do
      id = transaction.id
      name = Faker::Name.name
      description = Faker::Book.publisher
      facade.update transaction, attributes: { name: name, description: description }

      subitem_from_db = Transaction.find(id)
      expect(subitem_from_db.name).to eq(name)
      expect(subitem_from_db.description).to eq(description)
    end

    it 'return message error update with same name' do

      other_subitem = create(:transaction, item: item)

      name = other_subitem.name
      transporter = facade.update(transaction, attributes: { name: name })

      expect(transporter.status_red?).to be true
    end
  end

  context 'delete' do
    it 'decrease one item' do

      transaction = create(:transaction, item: item)
      expect {
        facade.delete(transaction)
      }.to change(Transaction, :count).by(-1)
    end

    it 'return error account with association' do

      account = create(:account, accountant: accountant)
      transaction = create(:transaction, item: item)
      create(:transaction, transaction: transaction, account: account)

      transport = nil
      expect {
        transport = facade.delete(transaction)
      }.to change(Transaction, :count).by(0)

      expect(transport.status_red?).to be true
    end
  end

  context 'select' do

    it 'return list of items' do
      amount = 10
      create_list(:transaction, amount, item: item)

      transporter = facade.select Transaction.new
      expect(transporter.bucket[:subitems].count).to eq(amount)
    end
  end

end
