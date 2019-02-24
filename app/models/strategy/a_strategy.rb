module Strategy
  class AStrategy

    def initialize(transporter)
      raise 'Deve inicializar com objeto do tipo "Transporter"' unless transporter.is_a? Transporter
      @transporter = transporter
    end

    def process
      raise 'Must implement this method'
    end

    def messages
      @transporter.messages
    end

    def entity
      @transporter.entity
    end

    def bucket
      @transporter.bucket
    end

    def driver
      @transporter.driver
    end

    def status
      @transporter.status
    end

    def set_status(s)
      @transporter.status = s
    end

    def add_message(msg)
      @transporter.add_message msg
    end

  end

end
