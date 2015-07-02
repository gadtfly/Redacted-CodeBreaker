require 'base64'

module SuperDuper
  class Plaintext
    class << self
      def from_base64(base64_ciphertext, key)
        self.new(Base64.decode64(base64_ciphertext), key)
      end
    end

    def initialize(ciphertext, key)
      @ciphertext = ciphertext
      @key        = key
    end

    def chars
      @ciphertext.chars.lazy.each_with_index.map do |c, i|
        as_ords(c, key_for(i), &:-)
      end
    end

    def to_s
      self.chars.to_a.join
    end

  private

    def as_ords(c1, c2)
      (yield(c1.ord, c2.ord) % 256).chr
    end

    def key_for(i)
      @key[i % @key.length]
    end
  end
end
