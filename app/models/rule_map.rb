module RuleMap
  @@rule_of_insert = {}
  @@rule_of_update = {}
  @@rule_of_destroy = {}
  @@rule_of_list = {}

  def rules_of_insert(strategies)
    @@rule_of_insert[entity_to_symbol] = strategies
  end

  def rules_of_update(strategies)
    @@rule_of_update[entity_to_symbol] = strategies
  end

  def rules_of_destroy(strategies)
    @@rule_of_destroy[entity_to_symbol] = strategies
  end

  def rules_of_list(strategies)
    @@rule_of_list[entity_to_symbol] = strategies
  end

  def self.insert(entity)
    load
    @@rule_of_insert[make_symbol(entity)]
  end

  def self.update(entity)
    load
    @@rule_of_update[make_symbol(entity)]
  end

  def self.destroy(entity)
    load
    @@rule_of_destroy[make_symbol(entity)]
  end

  def self.list(entity)
    load
    @@rule_of_list[make_symbol(entity)]
  end

  def self.make_symbol(entity)
    entity.is_a?(Symbol) ? entity : entity.class.name.underscore.downcase.to_sym
  end

  def self.load
    @load ||= load_entities
  end

  def self.load_entities
    model_path = File.join(Rails.root, 'app', 'models')
    Dir.glob("#{model_path}/*.rb") do |path|
      name_file = path.split('/').last
      name_file.split('.').first.camelize.constantize
    end
    true
  end

  private

  def entity_to_symbol
    self.to_s.underscore.downcase.to_sym
  end

end