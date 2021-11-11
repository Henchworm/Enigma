require './lib/enigma'

RSpec.describe Enigma do
  it "exists" do
    enigma = Enigma.new
    expect(enigma).to be_an(Enigma)
  end

  it "alphabet" do
    enigma = Enigma.new
    expect(enigma.alphabet).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
  end

  it "key generator" do
    enigma = Enigma.new
    range = Range.new(1,5)
    expect(enigma.key_generator).to be_a(String)
    expect(enigma.key_generator.length).to eq(5)
    expect(range.include?(enigma.key_generator.length)).to eq(true)
  end
end