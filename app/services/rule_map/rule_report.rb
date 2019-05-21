module RuleMap
  class RuleReport

    def self.select(transporter)
      [
          Strategy::Transfers::Filter.new(transporter),
          Strategy::Reports::PieChart.new(transporter),
          Strategy::Reports::LineChart.new(transporter),
      ]
    end

  end
end