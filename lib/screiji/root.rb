

module Screiji
  class Root
    def initialize(schema)
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
        [true, false].sample
      when 'integer'
        Random.rand(1 .. 1000)
      when 'number'
        Random.rand(-1000 .. 1000)
      when 'null'
        nil
      when 'string'
        rand(36**5).to_s(36)
      else
        raise "cant generate example for Array and Object"
      end
    end
  end
end
