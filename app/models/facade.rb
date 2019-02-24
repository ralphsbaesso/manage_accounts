class Facade

  def initialize(driver)
    @driver = driver
    @map = {
        transfer: RuleMap::RuleMapTransfer,
        item: RuleMap::RuleMapItem,
        account: RuleMap::RuleMapAccount,
        subitem: RuleMap::RuleMapSubitem,
        task: RuleMap::RuleMapTask,
    }
  end


  def insert(entity, args={})
    @transporter = Transporter.new(@driver)
    @transporter.entity = entity
    @transporter.bucket = args
    strategies = @map[entity.class.name.downcase.to_sym].insert(@transporter)
    execute strategies
    @transporter
  end
   
  def select(entity, args={})
     @transporter = Transporter.new(@driver)
     @transporter.entity = entity
     @transporter.bucket = args
     strategies = @map[entity.class.name.downcase.to_sym].select(@transporter)
     execute strategies
     @transporter
  end

  def update(entity, args={})
    @transporter = Transporter.new(@driver)
    @transporter.entity = entity
    @transporter.bucket = args

    check_attributes
    strategies = @map[entity.class.name.downcase.to_sym].update(@transporter)
    execute strategies
    @transporter
  end

  def delete(entity, args={})
    @transporter = Transporter.new(@driver)
    @transporter.entity = entity
    @transporter.bucket = args
    strategies = @map[entity.class.name.downcase.to_sym].delete(@transporter)
    execute strategies
    @transporter
  end


  private

  def execute(strategies)

    puts ">>>>>>>>>>>>>>   Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|

      puts "Executando Strategy: #{strategy.class.name}."

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
end