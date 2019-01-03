module RuleMap
  class RuleMapTask

    def self.insert
      [
          Strategy::SaveEntity
      ]
    end

    def self.delete
      [
          Strategy::DestroyEntity
      ]
    end

    def self.update
      [
          Strategy::UpdateEntity
      ]
    end
  end
end