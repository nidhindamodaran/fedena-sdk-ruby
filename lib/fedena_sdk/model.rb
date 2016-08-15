module FedenaSdk
  class Model
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def self.get_data_hash(url, options = {})
      xml = FedenaSdk.access_token.get(url, options).body
      Hash.from_xml xml
    end
  end
end
