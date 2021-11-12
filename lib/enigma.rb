require 'date'
class Enigma
  attr_reader :alphabet,
              :encrypted
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def key_generator
   rand(99999).to_s.rjust(5, '0')
  end

  def offset_generator(date = Date.today)
    if date.class == Date
     formatted = date.strftime("%-d,%-m,%y").gsub(/,/, '')
     (formatted.to_i ** 2).to_s.split("").last(4)
   else
     (date.to_i ** 2).to_s.split("").last(4)
    end.join
  end

  def shift(randkey = key_generator, offset = offset_generator)
    key_pairs = randkey.split("").map(&:to_i).each_cons(2).map {|a| a.join.to_i}
    shift_hash = {
      "A" => (key_pairs[0] + offset[0].to_i),
      "B" => (key_pairs[1] + offset[1].to_i),
      "C" => (key_pairs[2] + offset[2].to_i),
      "D" => (key_pairs[3] + offset[3].to_i)
    }
  end

  def encrypt(message, key = key_generator, date = offset_generator)
    date = offset_generator(date)
    shift_hash = shift(key, date)
    encrypted = []
    message = message.downcase.strip.split("")
    message.each_with_index do |character, index|
      if index % 4 == 0
        rotation_1 = @alphabet.rotate(alphabet.index(character))
        rotation_2 = rotation_1.rotate(shift_hash['A'])
          encrypted << rotation_2[0]
      elsif index % 4 == 1
        rotation_1 = @alphabet.rotate(alphabet.index(character))
        rotation_2 = rotation_1.rotate(shift_hash['B'])
          encrypted << rotation_2[0]
      elsif index % 4 == 2
        rotation_1 = @alphabet.rotate(alphabet.index(character))
        rotation_2 = rotation_1.rotate(shift_hash['C'])
          encrypted << rotation_2[0]
      elsif index % 4 == 3
        rotation_1 = @alphabet.rotate(alphabet.index(character))
        rotation_2 = rotation_1.rotate(shift_hash['D'])
          encrypted << rotation_2[0]
      end
    end
    encryption_hash = {
       'encryption': encrypted.join,
       'key': key,
       'date': "040895"
     }
  end
end
