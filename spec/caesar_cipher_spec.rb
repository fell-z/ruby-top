require_relative "../caesar-cipher/main"

describe "caesar_cipher method" do
  context "when is given a right shift factor of 4 (positive value)" do
    let(:shift_factor) { 4 }

    it 'returns "Hi mom" ciphered' do
      ciphered_text = caesar_cipher("Hi mom", shift_factor)

      expect(ciphered_text).to eq("Lm qsq")
    end

    it 'returns "Hello, world!" ciphered only changing the letters' do
      ciphered_text = caesar_cipher("Hello, world!", shift_factor)

      expect(ciphered_text).to eq("Lipps, asvph!")
    end
  end

  context "when is given a left shift factor of 6 (negative value)" do
    let(:shift_factor) { -6 }

    it 'returns "Hi mom" ciphered' do
      ciphered_text = caesar_cipher("Hi mom", shift_factor)

      expect(ciphered_text).to eq("Bc gig")
    end
  end

  context "when a word have letters that will need to wrap to other letters(z -> a)" do
    it 'returns "Caesar" ciphered with a shift factor of -5' do
      ciphered_text = caesar_cipher("Caesar", -5)

      expect(ciphered_text).to eq("Xvznvm")
    end

    it 'returns "Wishing Well" ciphered with a shift factor of 8' do
      ciphered_text = caesar_cipher("Wishing Well", 8)

      expect(ciphered_text).to eq("Eqapqvo Emtt")
    end
  end
end
