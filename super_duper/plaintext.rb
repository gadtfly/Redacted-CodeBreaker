require 'base64'
require_relative 'text'

module SuperDuper
  class Plaintext < Text
    def chars
      super(&:-)
    end
  end
end
