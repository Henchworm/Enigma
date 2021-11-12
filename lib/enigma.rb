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
     square = (formatted.to_i ** 2).to_s.split("")
     offset = square.last(4)
     offset.map do |integer|
       integer.to_i
     end
  end

  def shift(randkey = key_generator, offset = offset_generator)
    keys_in_pairs = randkey.each_cons(2).map {|a| a.join.to_i}
    shift_hash = {
      "A" => (keys_in_pairs[0] + offset[0]),
      "B" => (keys_in_pairs[1] + offset[1]),
      "C" => (keys_in_pairs[2] + offset[2]),
      "D" => (keys_in_pairs[3] + offset[3])
    }
  end

  def encrypt(message, key = key_generator, date = offset_generator)
    encrypted = []
    shift_hash = shift(key, date)
    message = message.downcase.strip.split("")
    message.each_with_index do |character, index|
      if index % 4 == 0
        char_index = @alphabet.index(character)
        rotation_1 = @alphabet.rotate(char_index)
        rotation_2 = rotation_1.rotate(shift_hash['A'])
          encrypted << rotation_2[0]
      elsif index % 4 == 1
        char_index = @alphabet.index(character)
        rotation_1 = @alphabet.rotate(char_index)
        rotation_2 = rotation_1.rotate(shift_hash['B'])
          encrypted << rotation_2[0]
      elsif index % 4 == 2
        char_index = @alphabet.index(character)
        rotation_1 = @alphabet.rotate(char_index)
        rotation_2 = rotation_1.rotate(shift_hash['C'])
          encrypted << rotation_2[0]
      elsif index % 4 == 3
        char_index = @alphabet.index(character)
        rotation_1 = @alphabet.rotate(char_index)
        rotation_2 = rotation_1.rotate(shift_hash['D'])
          encrypted << rotation_2[0]
      end
    end
    encrypted.join
  end
end
# encryption_hash = {
#     'encryption' => encrypted.join,
#     'key' => key.join,
#     'date' => date.join
#   }
