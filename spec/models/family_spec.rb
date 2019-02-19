# == Schema Information
#
# Table name: families
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Family, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:name) }
  end

end
