require 'date'
class Enigma
  attr_reader :alphabet
  def initialize
  @alphabet = ("a".."z").to_a << " "
  end

  def key_generator
    integers = (0..9).to_a
    lengths = (1..5).to_a
    key_array = []
    lengths.sample.times do
      key_array << integers.sample.to_s
    end
    key_array.join.rjust(5, "0")
  end

  def offset_generator(date = Date.today)
     formatted = date.strftime("%-d,%-m,%y").gsub(/,/, '')
     square = (formatted.to_i ** 2).to_s.split("")
     offset = square.last(4).join.to_i
  end

end
