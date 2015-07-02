describe SuperDuperCodec do
  describe '::encode' do
    it 'changes the plaintext somehow' do
      expect(SuperDuperCodec.encode('asdf', 'qwer')).to_not include('asdf')
    end
  end

  describe '::decode' do
    it 'reproduces the plaintext exactly' do
      expect(SuperDuperCodec.decode(SuperDuperCodec.encode('asdf', 'qwer'), 'qwer')).to eq('asdf')
    end
  end
end
