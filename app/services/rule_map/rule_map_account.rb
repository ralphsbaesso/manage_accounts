module RuleMap
  class RuleMapAccount

    def self.insert(transporter)
      [
        Strategy::Accounts::CheckName.new(transporter),
        Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.delete(transporter)
      [
        Strategy::Accounts::CheckAssociation.new(transporter),
        Strategy::DestroyEntity.new(transporter),
      ]
    end

    def self.update(transporter)
      [
          Strategy::Accounts::CheckName.new(transporter),
          Strategy::SaveEntity.new(transporter),
      ]
    end
  end
end