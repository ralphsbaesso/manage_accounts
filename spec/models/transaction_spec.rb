
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
