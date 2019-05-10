module SuperLogger
  ARROW = " \u27f6"

  def info(value)
    now = DateTime.now.strftime("%y-%m-%d %H:%M:%S")
    Rails.logger.info "#{ARROW} INFO (#{now}) <#{self.class.name}> : #{value}"
  end
end