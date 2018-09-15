class Transporter

  attr_accessor :messages, :status, :entity, :map

  def initialize
    @messages = []
    @status = 'GREEN'
    @map = {}
  end
end