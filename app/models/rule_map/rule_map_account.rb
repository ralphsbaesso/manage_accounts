module RuleMap
  class RuleMapAccount

    def self.insert
      [
        Strategy::CheckExistEntity,
        Strategy::SaveEntity,
      ]
    end

    def self.delete
      []
    end

    def self.update
      [Strategy::CheckEqualsNameEntityToUpdate]
    end
  end
end