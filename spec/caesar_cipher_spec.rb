require_relative "../caesar-cipher/main"

describe "caesar_cipher method" do
  context "can cipher words with a right shift factor of 4" do
    let(:shift_factor) { 4 }

    it 'returns "Hello" ciphered' do
      ciphered_text = caesar_cipher("Hello", shift_factor)

      expect(ciphered_text).to eq("Lipps")
    end

    it 'returns "This is a secret message." ciphered without changing the spaces or punctuation.' do
      ciphered_text = caesar_cipher("This is a secret message.", shift_factor)

      expect(ciphered_text).to eq("Xlmw mw e wigvix qiwweki.")
    end
  end
end
