require 'spec_helper'
require 'json'

describe Screiji::CLI do
  it 'dont raise error by generate string example' do
    json = <<-JSON
    {
      "$schema": "http://json-schema.org/draft-04/schema#",
      "type": "string"
    }
    JSON
    expect { Screiji::CLI.reiji(JSON.parse(json)) }.to output.to_stdout
  end

  it 'dont raise error by generate object' do
    json = <<-JSON
    {
      "$schema": "http://json-schema.org/draft-04/schema#",
      "type": "object",
      "properties": {
        "p": {
          "type": "string"
        }
      }
    }
    JSON
    expect { Screiji::CLI.reiji(JSON.parse(json)) }.to output.to_stdout
  end

  it 'dont raise error by generate array' do
    json = <<-JSON
    {
      "$schema": "http://json-schema.org/draft-04/schema#",
      "type": "array",
      "items": {
        "type": "string"
      }
    }
    JSON
    expect { Screiji::CLI.reiji(JSON.parse(json)) }.to output.to_stdout
  end
end
