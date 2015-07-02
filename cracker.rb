require 'base64'

class Cracker
  class << self
    def from_base64(decoder, ciphertext)
      self.new(decoder, Base64.decode64(ciphertext))
    end
  end

  DICTIONARY_WORDS = File.read('/usr/share/dict/words').lines.map(&:strip).map(&:downcase)

  def initialize(decoder, ciphertext)
    @decoder    = decoder
    @ciphertext = ciphertext
  end

  def key
    DICTIONARY_WORDS.find do |dictionary_word|
      @decoder.new(@ciphertext, dictionary_word).chars.all?(&method(:printable?))
    end
  end

  def plaintext
    @decoder.new(@ciphertext, self.key)
  end

private

  def printable?(s)
    s =~ /[[:print:]]/
  end

  def alpha(s)
    s.scan(/[[:alpha:]]/)
  end
end


require_relative 'super_duper_codec'
puts Cracker.from_base64(SuperDuper::Plaintext, File.read('message')).plaintext
# puts Cracker.from_base64(SuperDuper::Plaintext, SuperDuperCodec.encode('this is the plaintext', 'brother')).plaintext
