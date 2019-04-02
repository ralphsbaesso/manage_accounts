module RuleMap
  class RuleMapTask

    def self.insert(transporter)
      [
        Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.delete(transporter)
      [
        Strategy::DestroyEntity.new(transporter),
      ]
    end

    def self.update(transporter)
      [
        Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.select(transporter)
      [
        Strategy::Tasks::Filter.new(transporter),
      ]
    end
  end
end