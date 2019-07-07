
require 'rails_helper'

RSpec.describe RuleMap do

  context '.initialize' do

    it 'must have list of rules when initialize for all mapped models' do

      # model_path = File.join(Rails.root, 'app', 'models')
      # Dir.glob("#{model_path}/*.rb") do |path|
      #   name_file = path.split('/').last
      #   name_entity = name_file.split('.').first.camelize.constantize
      #   # p name_entity
      # end


      entity = :account
      expect(RuleMap.insert(entity)).to be_a Array
    end
  end

end
