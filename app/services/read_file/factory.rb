class ReadFile::Factory
  class << self
    def build(header_file)
      name_class = header_file.camelize
      constant = "ReadFile::#{name_class}".constantize
      constant.new
    end
  end
end