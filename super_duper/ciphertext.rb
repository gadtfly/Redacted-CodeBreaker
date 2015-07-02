require 'base64'
require_relative 'text'

module SuperDuper
  class Ciphertext < Text
    def chars
      super(&:+)
    end
  end
end
