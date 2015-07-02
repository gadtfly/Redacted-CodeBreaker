def original_python!(*args)
  `python spec/super_duper_codec.py #{args.map(&:inspect).join(' ')}`
end

describe SuperDuperCodec do
  let(:plaintext){ 'this is the plain text!' }
  let(:key){ 'brother' }
  let(:ciphertext){ SuperDuperCodec.encode(plaintext, key) }

  describe '::encode' do
    it 'changes the plaintext somehow' do
      expect(ciphertext).to_not include(plaintext)
    end

    it 'ciphertext matches original python' do
      expect(ciphertext.strip).to eq(original_python!('encode', plaintext, key).strip)
    end
  end

  describe '::decode' do
    it 'reproduces the plaintext exactly' do
      expect(SuperDuperCodec.decode(ciphertext, key)).to eq(plaintext)
    end

    it 'plaintext matches original python' do
      expect(SuperDuperCodec.decode(ciphertext, key).strip).to eq(original_python!('decode', ciphertext, key).strip)
    end
  end

  describe SuperDuperCodec::Cracker do
    describe '::cracked?' do
      it 'recognizes plaintext as cracked' do
        expect(SuperDuperCodec::Cracker.cracked?(plaintext)).to eq(true)
      end

      it 'does not recognize incorrectly decoded text as cracked' do
        expect(SuperDuperCodec::Cracker.cracked?(SuperDuperCodec.decode(ciphertext, 'sister'))).to eq(false)
      end

      it 'does not recognize gibberrish as cracked' do
        expect(SuperDuperCodec::Cracker.cracked?("asdf")).to eq(false)
      end
    end

    describe '#crack!' do
      it 'recovers the plaintext exactly' do
        expect(SuperDuperCodec::Cracker.crack!(ciphertext)).to eq(plaintext)
      end
    end
  end
end
