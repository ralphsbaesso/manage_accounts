class Transporter

  attr_accessor :messages, :status, :entity, :bucket, :current_accountant

  def initialize(accountant=nil)
    raise 'Deve passar o current_account na inicialização!' unless accountant
    @current_accountant = accountant
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