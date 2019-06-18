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
    @@rule_of_insert[make_symbol(entity)]
  end

  def self.update(entity)
    @@rule_of_update[make_symbol(entity)]
  end

  def self.destroy(entity)
    @@rule_of_destroy[make_symbol(entity)]
  end

  def self.list(entity)
    @@rule_of_list[make_symbol(entity)]
  end

  def self.make_symbol(entity)
    entity.is_a?(Symbol) ? entity : entity.class.name.underscore.downcase.to_sym
  end

  private

  def entity_to_symbol
    self.to_s.underscore.downcase.to_sym
  end

end