module RuleMap
  class RuleMapTransfer

    def self.insert
      [
          Strategy::StrategyTransfer::CheckAccounts,
      ]
    end

    def self.delete
    end

    def self.update
    end
  end
end