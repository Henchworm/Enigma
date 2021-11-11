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
      key_array << integers.sample
    end
    until key_array.count == 5
      key_array.unshift(0)
    end
    key_array
  end

  def offset_generator(date = Date.today)
     formatted = date.strftime("%-d,%-m,%y").gsub(/,/, '')
     square = (formatted ** 2).to_s.split("")
     offset = square.last(4)
  end

  def shift
    key_generator
    offset_generator
    require "pry"; binding.pry
  end





end
