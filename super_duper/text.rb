module SuperDuper
  class Text
    class << self
      def from_base64(base64_text, key)
        self.new(Base64.decode64(base64_text), key)
      end
    end

    def initialize(text, key)
      @text = text
      @key  = key
    end

    def chars(&combining_operation)
      @text.chars.lazy.each_with_index.map do |c, i|
        as_ords(c, key_for(i), &combining_operation)
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
