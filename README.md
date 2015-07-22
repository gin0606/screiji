# Screiji = JSON Schema + 例示

[![Gem Version](https://badge.fury.io/rb/screiji.svg)](http://badge.fury.io/rb/screiji) [![Build Status](https://travis-ci.org/gin0606/screiji.svg)](https://travis-ci.org/gin0606/screiji)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'screiji'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install screiji

## Usage

```rb
require 'json'

json_schema = <<-JSON
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "foo": {
      "type": "string",
      "example": "foo string"
    }
  }
}
JSON

puts Screiji.example(JSON.parse(json_schema)) # => {"foo"=>"foo string"}
```

## Contributing
1. Fork it ( https://github.com/[my-github-username]/screiji/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
