

require 'rails_helper'

RSpec.describe Subitem, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:level) }
  end

  let!(:accountant) { create(:accountant) }
  let!(:item) { create(:item, accountant: accountant) }
  let!(:facade) { Facade.new(accountant) }

  context 'Save' do
    it 'increase one item' do

      subitem = build(:subitem, item: item)
      expect {
        facade.insert(subitem)
      }.to change(Subitem, :count).by(1)
    end

    it 'not save if name already existing' do
      name = Faker::FunnyName.name
      create(:subitem, item: item, name: name)
      subitem = build(:subitem, item: item, name: name)
      expect {
        facade.insert(subitem)
      }.to change(Subitem, :count).by(0)
    end
  end

  context 'update' do
    let!(:subitem) { create(:subitem, item: item) }

    it 'modify attributes' do
      id = subitem.id
      name = Faker::Name.name
      description = Faker::Book.publisher
      facade.update subitem, attributes: { name: name, description: description }

      subitem_from_db = Subitem.find(id)
      expect(subitem_from_db.name).to eq(name)
      expect(subitem_from_db.description).to eq(description)
    end

    it 'return message error update with same name' do

      other_subitem = create(:subitem, item: item)

      name = other_subitem.name
      transporter = facade.update(subitem, attributes: { name: name })

      expect(transporter.status_red?).to be true
    end
  end

  context 'delete' do
    it 'decrease one item' do

      subitem = create(:subitem, item: item)
      expect {
        facade.delete(subitem)
      }.to change(Subitem, :count).by(-1)
    end

    it 'return error account with association' do

      account = create(:account, accountant: accountant)
      subitem = create(:subitem, item: item)
      create(:transaction, subitem: subitem, account: account)

      transport = nil
      expect {
        transport = facade.delete(subitem)
      }.to change(Subitem, :count).by(0)

      expect(transport.status_red?).to be true
    end
  end

  context 'select' do

    it 'return list of items' do
      amount = 10
      create_list(:subitem, amount, item: item)

      transporter = facade.select Subitem.new
      expect(transporter.bucket[:items].count).to eq(amount)
    end
  end

end
