module RuleMap
  class RuleMapSubitem

    def self.insert(transporter)
      [
          Strategy::Subitems::CheckName.new(transporter),
          Strategy::SaveEntity.new(transporter)
      ]
    end

    def self.update(transporter)
      [
          Strategy::Subitems::CheckName.new(transporter),
          Strategy::SaveEntity.new(transporter)
      ]
    end

    def self.delete(transporter)
      [
          Strategy::CheckAssociation.new(transporter),
          Strategy::DestroyEntity.new(transporter)
      ]
    end
  end
end