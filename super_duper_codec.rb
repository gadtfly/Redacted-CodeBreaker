require 'base64'

module SuperDuperCodec
  class << self
    def encode(plaintext, key)
      ciphertext = ''
      plaintext.length.times do |i|
        character = plaintext[i]
        key_char = key[i % key.length]
        cipher_character = (character.ord + key_char.ord) % 256
        ciphertext += cipher_character.chr
      end
      Base64.strict_encode64(ciphertext)
    end

    def decode(ciphertext, key)
      ciphertext = Base64.strict_decode64(ciphertext)
      plaintext = ''
      ciphertext.length.times do |i|
        character = ciphertext[i]
        key_char = key[i % key.length]
        plain_character = (character.ord - key_char.ord) % 256
        plaintext += plain_character.chr
      end
      plaintext
    end
  end

  module Cracker
    class << self
      DICT = File.read('/usr/share/dict/words').lines.map(&:strip).map(&:downcase)

      def unprintable_characters(s)
        s.scan(/[^[:print:]]/)
      end

      def words(s)
        s.scan(/[[:alnum:]]+/)
      end

      def cracked?(s)
        s = s.downcase
        unprintable_characters(s).empty? && words(s).all?(&DICT.method(:include?))
      end

      def find_key!(ciphertext)
        DICT.find do |candidate_key|
          cracked?(SuperDuperCodec.decode(ciphertext, candidate_key))
        end
      end

      def crack!(ciphertext)
        SuperDuperCodec.decode(ciphertext, find_key!(ciphertext))
      end
    end
  end
end
