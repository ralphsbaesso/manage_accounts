class Transporter

  attr_accessor :messages, :status, :entity, :map, :current_accountant

  def initialize
    @messages = []
    @status = 'GREEN'
    @map = {}
  end
end