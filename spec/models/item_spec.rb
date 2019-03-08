

require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
  end

  let!(:accountant) { create(:accountant) }
  let!(:facade) { Facade.new(accountant) }

  context 'Save' do
    it 'increase one item' do

      item = build(:item, accountant: accountant)
      expect {
        facade.insert(item)
      }.to change(Item, :count).by(1)
    end

    it 'not save if name already existing' do
      name = Faker::Dog.name
      create(:item, accountant: accountant, name: name)
      item = build(:item, accountant: accountant, name: name)
      expect {
        facade.insert(item)
      }.to change(Item, :count).by(0)
    end
  end

  context 'update' do
    let!(:item) { create(:item, accountant: accountant) }

    it 'modify attributes' do
      id = item.id
      name = Faker::Name.name
      description = Faker::Book.publisher
      facade.update item, attributes: { name: name, description: description }

      item_from_db = Item.find(id)
      expect(item_from_db.name).to eq(name)
      expect(item_from_db.description).to eq(description)
    end

    it 'return message error update with same name' do

      other_item = create(:item, accountant: accountant)

      name = other_item.name
      transporter = facade.update(item, attributes: { name: name })

      expect(transporter.status).to eq('RED')
    end
  end

  context 'delete' do
    it 'decrease one item' do

      item = create(:item, accountant: accountant)
      expect {
        facade.delete(item)
      }.to change(Item, :count).by(-1)
    end

    it 'return error account with association' do
      item = create(:item, accountant: accountant)
      create(:subitem, item: item)

      transport = nil
      expect {
        transport = facade.delete(item)
      }.to change(Item, :count).by(0)

      expect(transport.status).to eq('RED')
    end
  end

  context 'select' do

    it 'return list of items' do
      amount = 10
      create_list(:item, amount, accountant: accountant)

      transporter = facade.select Item.new
      expect(transporter.bucket[:items].count).to eq(amount)
    end
  end

end
