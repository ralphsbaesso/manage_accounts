class Facade
  include SuperLogger

  attr_reader :transporter

  def initialize(driver)
    @transporter = Transporter.new(driver)
    @map = {
        transfer: RuleMap::RuleTransfer,
        item: RuleMap::RuleItem,
        account: RuleMap::RuleAccount,
        subitem: RuleMap::RuleSubitem,
        task: RuleMap::RuleTask,
        bank_statement: RuleMap::RuleBankStatement,
        report: RuleMap::RuleReport,
    }
  end


  def insert(entity, args={})

    strategies =_strategies(entity)

    @transporter.entity = entity
    @transporter.bucket = args
    # strategies = @map[make_symbol(entity)].insert(@transporter)
    execute strategies
    @transporter
  end
   
  def select(entity, args={})
     @transporter = Transporter.new(@driver)
     @transporter.entity = entity
     @transporter.bucket = args
     strategies = @map[make_symbol(entity)].select(@transporter)
     execute strategies
     @transporter
  end

  def update(entity, args={})
    @transporter = Transporter.new(@driver)
    @transporter.entity = entity
    @transporter.bucket = args

    check_attributes
    strategies = @map[make_symbol(entity)].update(@transporter)
    execute strategies
    @transporter
  end

  def delete(entity, args={})
    @transporter = Transporter.new(@driver)
    @transporter.entity = entity
    @transporter.bucket = args
    strategies = @map[make_symbol(entity)].delete(@transporter)
    execute strategies
    @transporter
  end


  private

  def execute(strategies)

    info "Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|

       info "Executando Strategy: #{strategy.class.name}."

       unless strategy.process
         return
       end
    end
  end

  def check_attributes
    attributes = @transporter.bucket[:attributes]
    if attributes.present?
      entity = @transporter.entity

      attributes.each do |key, value|
        entity[key] = value if entity.respond_to? key
      end

    end
  end

  def make_symbol(entity)
    if entity.is_a? Symbol
      return entity
    else
      return entity.class.name.underscore.downcase.to_sym
    end
  end

  def _strategies(entity)

    rule = "Rule#{entity.class.name.capitalize}".constantize
    s = rule.insert.map { |rule| rule.new(@transporter) }
    p s

    s

  end
end