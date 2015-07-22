require 'screiji'
require 'json'

module Screiji
  class CLI
    class << self
      def reiji(file)
        puts JSON.pretty_generate(Screiji.example(file))
      end
    end
  end
end
