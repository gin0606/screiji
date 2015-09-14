require 'spec_helper'

describe Screiji do
  it 'has a version number' do
    expect(Screiji::VERSION).not_to be_nil
  end

  describe 'primitive type' do
    it 'return example boolean' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'boolean',
        'example' => false
      }
      example = Screiji.example schema
      expect(example).to eq false
    end

    it 'return example integer' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'integer',
        'example' => 1234
      }
      example = Screiji.example schema
      expect(example).to eq 1234
    end

    it 'return example number' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'number',
        'example' => 0.1234
      }
      example = Screiji.example schema
      expect(example).to eq 0.1234
    end

    it 'return example null' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'null',
        'example' => nil
      }
      example = Screiji.example schema
      expect(example).to be_nil
    end

    it 'return example string' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'string',
        'example' => 'example text'
      }
      example = Screiji.example schema
      expect(example).to eq 'example text'
    end

  end

  describe 'object' do
    it 'return hash' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'object',
        'properties' => {
          'string_property' => {
            'type' => 'string',
            'example' => 'foo'
          },
          'object_property' => {
            'type' => 'object',
            'properties' => {
              'p' => {
                'type' => 'string',
                'example' => 'object include object'
              }
            }
          }
        }
      }
      example = Screiji.example schema
      expect(example).to be_a Hash
      expect(example['string_property']).to eq 'foo'
      expect(example['object_property']['p']).to eq 'object include object'
    end

    it 'return adequate value if schema dont have example' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'object',
        'properties' => {
          'boolean_property' => {
            'type' => 'boolean',
          },
          'integer_property' => {
            'type' => 'integer',
          },
          'number_property' => {
            'type' => 'number',
          },
          'null_property' => {
            'type' => 'null',
          },
          'string_property' => {
            'type' => 'string',
          },
        }
      }
      example = Screiji.example schema
      expect(example).to be_a Hash
      expect([true, false]).to include example['boolean_property']
      expect(example['integer_property']).to eq 1234
      expect(example['number_property']).to eq 0.1234
      expect(example['null_property']).to be_nil
      expect(example['string_property']).to eq 'example'
    end

    it 'return fixed value with format' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'object',
        'properties' => {
          'datetime_property' => {
            'type' => 'string',
            'format' => 'date-time'
          },
          'email_property' => {
            'type' => 'string',
            'format' => 'email'
          },
          'hostname_property' => {
            'type' => 'string',
            'format' => 'hostname'
          },
          'ipv4_property' => {
            'type' => 'string',
            'format' => 'ipv4'
          },
          'ipv6_property' => {
            'type' => 'string',
            'format' => 'ipv6'
          },
          'uri_property' => {
            'type' => 'string',
            'format' => 'uri'
          },
        }
      }
      example = Screiji.example schema
      expect(example['datetime_property']).to eq '2002-10-02T15:00:00Z'
      expect(example['email_property']).to eq 'mail@example.org'
      expect(example['hostname_property']).to eq 'example.com'
      expect(example['ipv4_property']).to eq '192.0.2.0'
      expect(example['ipv6_property']).to eq '2001:0db8:bd05:01d2:288a:1fc0:0001:10ee'
      expect(example['uri_property']).to eq 'http://example.com'
    end

    context 'when schema do not specify type' do
      let(:schema) do
        {
          '$schema' => 'http://json-schema.org/draft-04/schema#',
          'properties' => {
            'integer_property' => {
              'type' => 'integer',
            },
          }
        }
      end
      subject { Screiji.example schema }
      it { is_expected.to be_a Hash }
    end
  end

  describe 'array items declaration by hash' do
    it 'return hash' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'array',
        'items' => {
          'type' => 'string',
          'example' => 'foo'
        }
      }
      example = Screiji.example schema
      expect(example).to be_a Array
      expect(example).to eq ['foo']
    end
  end

  describe 'array items declaration by array' do
    it 'return hash' do
      schema = {
        '$schema' => 'http://json-schema.org/draft-04/schema#',
        'type' => 'array',
        'items' => [
          {
            'type' => 'string',
            'example' => 'foo'
          },
          {
            'type' => 'boolean',
            'example' => false
          }
        ]
      }
      example = Screiji.example schema
      expect(example).to be_a Array
      expect(example).to include 'foo'
      expect(example).to include false
    end
  end
end
