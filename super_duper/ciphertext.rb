require 'base64'

module SuperDuper
  class Ciphertext
    def initialize(plaintext, key)
      @plaintext = plaintext
      @key        = key
    end

    def chars
      @plaintext.chars.lazy.each_with_index.map do |c, i|
        as_ords(c, key_for(i), &:+)
      end
    end

    def to_s
      self.chars.to_a.join
    end

    def to_base64
      Base64.strict_encode64(self.to_s)
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
