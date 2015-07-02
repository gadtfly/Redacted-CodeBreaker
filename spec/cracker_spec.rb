describe Cracker do
  let(:plaintext){ 'this is the plaintext' }
  let(:key){ 'brother' }
  let(:ciphertext){ SuperDuperCodec.encode(plaintext, key) }
  
  describe '::crack!' do
    it 'reconstructs the plaintext exactly' do
      expect(Cracker.base64_crack!(SuperDuper::Plaintext, ciphertext)).to eq(plaintext)
    end
  end
end
