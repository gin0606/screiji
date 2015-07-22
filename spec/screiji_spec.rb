require 'spec_helper'

describe Screiji do
  it 'has a version number' do
    expect(Screiji::VERSION).not_to be nil
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
      expect(example).to eq nil
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
