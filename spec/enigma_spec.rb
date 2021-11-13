
require_relative './spec_helper'
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

  it "specials_arrays" do
    enigma = Enigma.new
    expect(enigma.specials_arrays("he!ll?o! wor!ld!")).to eq( [["!2"], ["?5"], ["!7"], ["!12"], ["!15"]])
  end

  it "insert_specials" do
    enigma = Enigma.new
    message = "hello world!"
    encrypted = ["k","e","d","e","r"," ","o","h","u","l","w"]
    expect(enigma.insert_specials(encrypted, message)).to eq("keder ohulw!")
  end

  it "encrypt" do
    enigma = Enigma.new
    expect(enigma.encrypt("hello world!", "02715", Date.new(1995,8,4))).to eq({:encryption=> "keder ohulw!",  :key=>"02715", :date=>"040895"})
    expect(enigma.encrypt("HELLO WORLD", "02715", "040895")).to eq({:encryption=> "keder ohulw", :key=>"02715", :date=>"040895"})
    expect(enigma.encrypt("!hello world!", "02715", Date.new(1995,8,4))).to eq({:encryption=> "!keder ohulw!", :key=>"02715", :date=>"040895"})
    expect(enigma.encrypt("hello world!?", "02715", Date.new(1995,8,4))).to eq({:encryption=> "keder ohulw!?", :key=>"02715", :date=>"040895"})
    expect(enigma.encrypt("hello wor!ld", "02715", Date.new(1995,8,4))).to eq({:encryption=> "keder ohu!lw", :key=>"02715", :date=>"040895"})
    expect(enigma.encrypt("h!el?lo w!!!or?l^%$#62d", "02715", Date.new(1995,8,4))).to eq({:encryption=>"k!ed?er o!!!hu?l^%$#62w", :key=>"02715", :date=>"040895"})
    #no date + no date or key is encrypting but not yet sure how to test it.
  end

  it "hash_return" do
    enigma = Enigma.new
    expect(enigma.hash_return(['k','e','d','e','r',' ','o','h','u','l','w'],"02715", "040895")).to eq({
      :date=>"040895",
      :encryption=>"keder ohulw",
      :key=>"02715"
    })
  end

  it "date_formatter" do
    enigma = Enigma.new
    date_1 = Date.new(1995,8,4)
    date_2 = "040895"
    expect(enigma.date_formatter(date_1)).to eq("040895")
    expect(enigma.date_formatter(date_2)).to eq("040895")
  end

end