require "screiji/version"
require "screiji/root"

module Screiji
  extend self
  def example(schema)
    Root.new(schema).to_schema
  end
end
