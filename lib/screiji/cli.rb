require 'screiji'
require 'json'

module Screiji
  class CLI
    class << self
      def reiji(file)
        example = Screiji.example(file)
        case example
        when Array
        when Hash
          puts JSON.pretty_generate(example)
        else
          puts example
        end
      end
    end
  end
end
