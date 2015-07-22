require "screiji/version"
require "screiji/root"
require "screiji/cli"

module Screiji
  extend self
  def example(schema)
    Root.new(schema).to_schema
  end
end
