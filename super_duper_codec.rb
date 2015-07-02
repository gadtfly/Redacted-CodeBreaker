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
      Base64.encode64(ciphertext)
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
end
