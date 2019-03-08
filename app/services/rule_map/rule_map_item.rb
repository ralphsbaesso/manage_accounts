module RuleMap
  class RuleMapItem

    def self.insert(transporter)
      [
          Strategy::Items::CheckName.new(transporter),
          Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.delete(transporter)
      [
          Strategy::Items::CheckAssociation.new(transporter),
          Strategy::DestroyEntity.new(transporter)
      ]
    end

    def self.update(transporter)
      [
          Strategy::Items::CheckName.new(transporter),
          Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.select(transporter)
      [
        Strategy::Items::Filter.new(transporter)
      ]
    end
  end
end