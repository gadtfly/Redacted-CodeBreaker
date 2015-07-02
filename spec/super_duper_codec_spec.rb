describe SuperDuperCodec do
  describe '::encode' do

    it 'changes the plaintext somehow' do
      expect(SuperDuperCodec.encode('asdf', 'qwer')).to_not include('asdf')
    end

    it 'ciphertext matches original python' do
      expect(SuperDuperCodec.encode('asdf', 'qwer').strip).to eq(`python spec/super_duper_codec.py encode asdf qwer`.strip)
    end
  end

  describe '::decode' do
    let(:ciphertext){ SuperDuperCodec.encode('asdf', 'qwer') }

    it 'reproduces the plaintext exactly' do
      expect(SuperDuperCodec.decode(ciphertext, 'qwer')).to eq('asdf')
    end

    it 'plaintext matches original python' do
      expect(SuperDuperCodec.decode(ciphertext, 'qwer').strip).to eq(`python spec/super_duper_codec.py decode "#{ciphertext}" qwer`.strip)
    end
  end
end
