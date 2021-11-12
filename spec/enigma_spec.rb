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
    expect(enigma.key_generator).to be_an(Array)
    expect(enigma.key_generator.length).to eq(5)
    expect(enigma.key_generator.sample).to be_an(Integer)
    expect(range.include?(enigma.key_generator.length)).to eq(true)
  end

  it "offset generator" do
    enigma = Enigma.new
    expect(enigma.offset_generator(Date.new(1995,8,4))).to eq([1,0,2,5])
    expect(enigma.offset_generator.length).to eq(4)
  end

  it "shift" do
    enigma = Enigma.new
    expect(enigma.shift([0,2,7,1,5],[1,0,2,5])).to eq(
      {"A"=>3, "B"=>27, "C"=>73, "D"=>20})
    expect(enigma.shift.keys).to eq(["A","B","C","D"])
  end

  it "encrypt" do
    enigma = Enigma.new
    expect(enigma.encrypt("hello world", [0,2,7,1,5], [1,0,2,5])).to eq("keder ohulw")
  end



end