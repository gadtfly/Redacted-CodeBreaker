require_relative 'super_duper/ciphertext'
require_relative 'super_duper/plaintext'

module SuperDuperCodec
  class << self
    def encode(plaintext, key)
      SuperDuper::Ciphertext.new(plaintext, key).to_base64
    end

    def decode(base64_ciphertext, key)
      SuperDuper::Plaintext.from_base64(base64_ciphertext, key).to_s
    end
  end
end
