class Facade

  def initialize(driver)
    @driver = driver
    @map = {
        'Transfer': RuleMap::RuleMapTransfer,
        'Item': RuleMap::RuleMapItem,
        'Account': RuleMap::RuleMapAccount,
        'Subitem': RuleMap::RuleMapSubitem,
        'Task': RuleMap::RuleMapTask,
    }
  end


  def insert(entity, args={})
    @transporter = Transporter.new(@driver)
    strategies = @map[entity.class.name.to_sym].insert
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end
   
  def select(entity, args={})
     @transporter = Transporter.new(@driver)
     strategies = @map[entity.class.name.to_sym].select
     @transporter.entity = entity
     @transporter.bucket = args
     execute strategies
     @transporter
  end

  def update(entity, args={})
    @transporter = Transporter.new(@driver)
    strategies = @map[entity.class.name.to_sym].update
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end

  def delete(entity, args={})
    @transporter = Transporter.new(@driver)
    strategies = @map[entity.class.name.to_sym].delete
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end


  private

  def execute(strategies)

    puts ">>>>>>>>>>>>>>   Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|

       unless strategy.process(@transporter)
         return
       end
    end
  end
end