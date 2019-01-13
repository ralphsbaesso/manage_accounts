class Transporter

  attr_accessor :messages, :status, :entity, :map, :current_accountant

  def initialize
    @messages = []
    @status = 'GREEN'
    @map = {}
  end

  def add_message(msg)
    if msg.is_a? Array
      @messages += msg
    else
      @messages << msg
    end
  end
end