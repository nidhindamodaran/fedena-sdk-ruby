module FedenaSdk
  class Model
    def self.attr_accessor(*args)
      @attributes ||= []
      @attributes.concat args
      super(*args)
    end

    class << self
      attr_reader :attributes
    end

    def attributes
      self.class.attributes
    end

    def attributes_hash
      attributes.map { |attribute| { attribute => send(attribute) } }.reduce({}, :merge)
    end

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    # FIXME: better name for this method
    def self.get_data_hash(url, options = {})
      xml = FedenaSdk.access_token.get(url, options).body
      Hash.from_xml xml
    end

    def self.post_data_hash(url, options = {})
      xml = FedenaSdk.access_token.post(url, options).body
      Hash.from_xml xml
    end

    def post_data_hash *args
      self.class.post_data_hash *args
    end

    def get_data_hash *args
      self.class.get_data_hash *args
    end
  end
end
