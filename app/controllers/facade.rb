class Facade

   @@map = {
      'Item': RuleMapItem,
      'Account': RuleMapAccount
   }

  def self.insert(entity)
    @@transporter = Transporter.new
    strategies = @@map[entity.class.name.to_sym].insert
    @@transporter.entity = entity
    execute strategies
    @@transporter
  end



  def self.update(entity)
    @@transporter = Transporter.new
    strategies = @@map[entity.class.name.to_sym].update
    @@transporter.entity = entity
    execute strategies
    @@transporter
  end

  def self.delete(entity)
    @@transporter = Transporter.new
    strategies = @@map[entity.class.name.to_sym].delete
    @@transporter.entity = entity
    execute strategies
    @@transporter
  end


  private

  def self.execute(strategies)

    puts "Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|

       unless strategy.process(@@transporter)
         return
       end
    end
  end
end