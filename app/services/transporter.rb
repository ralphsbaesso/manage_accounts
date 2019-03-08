class Transporter

  attr_accessor :messages, :entity, :bucket, :driver

  def initialize(driver=nil)
    raise 'Deve passar o current_account na inicialização!' unless driver
    @driver = driver
    @messages = []
    @status = Transporter::Status.new
    @bucket = {}
  end

  def add_message(msg)
    if msg.is_a? Array
      @messages += msg
    else
      @messages << msg
    end
  end

  def status=(value)
    @status.status = value
  end

  def status
    @status
  end

  class Status

    attr_accessor :status

    def method_missing(method)

      method = method.to_s

      if method.end_with? '!'
        @status = method.gsub '!', ''
      elsif method.end_with? '?'
        method = method.gsub '?', ''
        return @status == method
      end
    end

  end
end