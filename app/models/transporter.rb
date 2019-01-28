class Transporter

  attr_accessor :messages, :status, :entity, :bucket, :driver

  def initialize(driver=nil)
    raise 'Deve passar o current_account na inicialização!' unless driver
    @driver = driver
    @messages = []
    @status = 'GREEN'
    @bucket = {}
  end

  def add_message(msg)
    if msg.is_a? Array
      @messages += msg
    else
      @messages << msg
    end
  end
end