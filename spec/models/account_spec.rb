

require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
  end

  let(:facade) { Facade.new(:system) }
  let(:accountant) { create(:accountant) }

  context 'Save' do
    it 'increase one account' do

      account = create(:account, accountant: accountant)
      facade.insert(account)

      count = Account.count

      expect(count).to eq(1)


    end
  end

end
