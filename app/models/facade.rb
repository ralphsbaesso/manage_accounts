class Facade
  include SuperLogger
  attr_reader :transporter

  def initialize(driver)
    @transporter = Transporter.new(driver)
  end

  def insert(entity, args={})
    transporter.entity = entity
    transporter.bucket = args
    strategies = RuleMap.insert(entity).map { |strategy| strategy.new(transporter) }
    execute strategies
    transporter
  end
   
  def select(entity, args={})
     transporter.entity = entity
     transporter.bucket = args
     strategies = RuleMap.list(entity).map { |strategy| strategy.new(transporter) }
     execute strategies
     transporter
  end

  def update(entity, args={})
    transporter.entity = entity
    transporter.bucket = args

    check_attributes
    strategies = RuleMap.update(entity).map { |strategy| strategy.new(transporter) }
    execute strategies
    transporter
  end

  def delete(entity, args={})
    transporter.entity = entity
    transporter.bucket = args
    strategies = RuleMap.destroy(entity).map { |strategy| strategy.new(transporter) }
    execute strategies
    transporter
  end


  private

  def execute(strategies)
    info "Quantidade de estrategias #{strategies.count}"

    strategies.each do |strategy|
       info "Executando Strategy: #{strategy.class.name}."

       return unless strategy.process
    end
  end

  def check_attributes
    attributes = transporter.bucket[:attributes]
    if attributes.present?
      entity = transporter.entity

      attributes.each do |key, value|
        entity[key] = value if entity.respond_to? key
      end

    end
  end

end