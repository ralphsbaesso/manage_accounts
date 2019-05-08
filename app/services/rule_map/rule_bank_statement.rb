module RuleMap
  class RuleBankStatement

    def self.insert(transporter)
      [
          Strategy::BankStatements::FileToTransfers.new(transporter),
          Strategy::BankStatements::CheckTransactionInDatabase.new(transporter),
          Strategy::BankStatements::SaveTransactions.new(transporter),
          Strategy::ClosedMonths::Update.new(transporter),
      ]
    end

    def self.delete(transporter)
      [
      ]
    end

    def self.update(transporter)
      [
      ]
    end

    def self.select(transporter)
      [
      ]
    end
  end
end