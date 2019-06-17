module RuleMap
  class RuleAccount

    # def self.insert(transporter)
    #   [
    #     Strategy::Accounts::CheckName.new(transporter),
    #     Strategy::SaveEntity.new(transporter),
    #   ]
    # end
    #
    # def self.delete(transporter)
    #   [
    #     Strategy::Accounts::CheckAssociation.new(transporter),
    #     Strategy::DestroyEntity.new(transporter),
    #   ]
    # end
    #
    # def self.select(transporter)
    #   [
    #       Strategy::Accounts::Filter.new(transporter),
    #       Strategy::Reports::LineChart.new(transporter),
    #   ]
    # end
    #
    # def self.update(transporter)
    #   [
    #       Strategy::Accounts::CheckName.new(transporter),
    #       Strategy::SaveEntity.new(transporter),
    #   ]
    # end
  end
end