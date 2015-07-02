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
      ciphertext = Base64.decode64(ciphertext)
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
      ARBITRARY_CHARACTER_SCORE_THRESHOLD = 0.95

      def unprintable_characters(s)
        s.scan(/[^[:print:]]/)
      end

      def words(s)
        s.scan(/[[:alpha:]]+/)
      end

      def likely_characters(s)
        s.scan(/[[:alpha:][:space:]]/)
      end

      def character_score(s)
        if unprintable_characters(s).empty?
          likely_characters(s).size.fdiv(s.size)
        else
          0
        end
      end

      def word_score(s)
        if character_score(s) >= ARBITRARY_CHARACTER_SCORE_THRESHOLD
          words(s).count(&DICT.method(:include?))
        else
          0
        end
      end

      def find_key!(ciphertext)
        DICT.max_by do |candidate_key|
          word_score(SuperDuperCodec.decode(ciphertext, candidate_key))
        end
      end

      def crack!(ciphertext)
        SuperDuperCodec.decode(ciphertext, find_key!(ciphertext))
      end
    end
  end
end
