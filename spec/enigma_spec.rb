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

  it "offset generator" do
    enigma = Enigma.new
    expect(enigma.offset_generator(Date.new(1995,8,4))).to eq("1025")
    expect(enigma.offset_generator.length).to eq(4)
    expect(enigma.offset_generator("040895")).to eq("1025")
  end

  it "shift" do
    enigma = Enigma.new
    expect(enigma.shift("02715", "1025")).to eq(
      {"A"=>3, "B"=>27, "C"=>73, "D"=>20})
    expect(enigma.shift.keys).to eq(["A","B","C","D"])
  end

  it "first_rotation" do
    enigma = Enigma.new
    expect(enigma.first_rotation("b")).to eq(["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a"])
  end

  it "pop specials" do
    enigma = Enigma.new
    expect(enigma.pop_specials("hello! wor!ld!")).to eq( ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d",])
  end

  it " specials_arrays" do
    enigma = Enigma.new
    expect(enigma.specials_arrays("he!ll?o! wor!ld!")).to eq( [["!2"], ["?5"], ["!7"], ["!12"], ["!15"]])
  end

  it "encrypt" do
    #FAKE HARDCODED DATE
    enigma = Enigma.new
    expect(enigma.encrypt("hello world!", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"keder ohulw!", :key=>"02715"})
    expect(enigma.encrypt("HELLO WORLD", "02715", "040895")).to eq({:date=>"040895", :encryption=>"keder ohulw", :key=>"02715"})
    expect(enigma.encrypt("!hello world!", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"!keder ohulw!", :key=>"02715"})
    expect(enigma.encrypt("hello world!?", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"keder ohulw!?", :key=>"02715"})
    expect(enigma.encrypt("hello wor!ld", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"keder ohu!lw", :key=>"02715"})
    expect(enigma.encrypt("h!el?lo w!!!or?l^%$#62d", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"k!ed?er o!!!hu?l^%$#62w", :key=>"02715"})
    #no date + no date or key is encrypting but not yet sure how to test it.
  end

  # it "decrypt" do
  #   enigma = Enigma.new
  #   expect(enigma.decrypt("keder ohulw", "02715", Date.new(1995,8,4))).to eq({:date=>"040895", :encryption=>"hello world", :key=>"02715"})
  # end




  it "hash_return" do
    enigma = Enigma.new
    expect(enigma.hash_return(['k','e','d','e','r',' ','o','h','u','l','w'],"02715", "040895")).to eq({
      :date=>"040895",
      :encryption=>"keder ohulw",
      :key=>"02715"
    })
  end
end