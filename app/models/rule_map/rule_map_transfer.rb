module RuleMap
  class RuleMapTransfer

    @@strategies = []

    def self.insert
      @@strategies << Strategy::StrategyTransfer::CheckAccounts
    end

    def self.delete
    end

    def self.update
    end
  end
end