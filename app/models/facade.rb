class Facade

   @map = {
      'Transfer': RuleMap::RuleMapTransfer,
      'Item': RuleMap::RuleMapItem,
      'Account': RuleMap::RuleMapAccount,
      'Subitem': RuleMap::RuleMapSubitem,
      'Task': RuleMap::RuleMapTask,
   }

  def self.insert(entity, accountant, args={})
    @transporter = Transporter.new(accountant)
    strategies = @map[entity.class.name.to_sym].insert
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end
   
  def self.select(entity, accountant, args={})
     @transporter = Transporter.new(accountant)
     strategies = @map[entity.class.name.to_sym].select
     @transporter.entity = entity
     @transporter.bucket = args
     execute strategies
     @transporter
  end

  def self.update(entity, accountant, args={})
    @transporter = Transporter.new(accountant)
    strategies = @map[entity.class.name.to_sym].update
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end

  def self.delete(entity, accountant, args={})
    @transporter = Transporter.new(accountant)
    strategies = @map[entity.class.name.to_sym].delete
    @transporter.entity = entity
    @transporter.bucket = args
    execute strategies
    @transporter
  end


  private

  def self.execute(strategies)

    puts ">>>>>>>>>>>>>>   Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|

       unless strategy.process(@transporter)
         return
       end
    end
  end
end