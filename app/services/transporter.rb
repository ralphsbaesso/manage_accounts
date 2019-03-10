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
    @status.status = value.to_sym
  end

  def status
    @status.status
  end

  def method_missing(method)

    method = method.to_s

    if method.start_with? 'status_'

      second_word = method.gsub 'status_', ''

      if second_word.end_with? '!'
        @status.status = second_word.gsub '!', ''
      elsif second_word.end_with? '?'
        second_word = second_word.gsub('?', '').to_sym
        return @status.status == second_word.to_sym
      end
    else
      raise 'Method missing'
    end

  end

  class Status
    attr_accessor :status
    def initialize
      @status = :green
    end
  end
end