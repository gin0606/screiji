require 'json'

module Screiji
  class Root
    def initialize(schema)
      schema = JSON.parse(File.read(schema)) if schema.is_a? String
      @schema = schema
    end

    def to_schema
      parse(@schema)
    end

    def parse(schema)
      case schema['type']
      when 'object'
        parse_object(schema)
      when 'array'
        parse_array(schema)
      else
        schema.has_key?('example') ? schema['example'] : example(schema)
      end
    end

    def parse_object(schema)
      Hash[schema['properties'].map {|k, v|
        [k, parse(v)]
      }]
    end

    def parse_array(schema)
      if schema['items'].is_a? Array
        schema['items'].map do |item|
          parse(item)
        end
      elsif schema['items'].is_a? Hash
        [parse(schema['items'])]
      else
        raise '`items` can include Array or Hash.'
      end
    end

    def example(schema)
      case schema['type']
      when 'boolean'
        true
      when 'integer'
        1234
      when 'number'
        0.1234
      when 'null'
        nil
      when 'string'
        string_example(schema)
      else
        raise "cant generate example for Array and Object"
      end
    end

    def string_example(schema)
      case schema['format']
      when 'date-time'
        '2002-10-02T15:00:00Z'
      when 'email'
        'mail@example.org'
      when 'hostname'
        'example.com'
      when 'ipv4'
        '192.0.2.0'
      when 'ipv6'
        '2001:0db8:bd05:01d2:288a:1fc0:0001:10ee'
      when 'uri'
        'http://example.com'
      else
        'example'
      end
    end
  end
end
