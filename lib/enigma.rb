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

  def specials_formatter(message)
    formatted = message.split('').map do |char|
      if !@alphabet.include?(char)
        char.to_sym
      elsif @alphabet.include?(char)
        char
      end
    end
    formatted
  end


  def first_rotation(character)
     @alphabet.rotate(alphabet.index(character))
  end

  def encrypt(message, key = key_generator, date = offset_generator)
    date = offset_generator(date) #need to deal with this
    shift_hash = shift(key, date)
    encrypted = []
    specials_formatter(message)
    #scanner with hash to make k/v pair.
    #OR iterate thru only the strings, ignoring symbols, convert back.
    message.downcase.split("").each_with_index do |character, index|
      if index % 4 == 0
        encrypted.push(first_rotation(character).rotate(shift_hash['A'])[0])
      elsif index % 4 == 1
        encrypted.push(first_rotation(character).rotate(shift_hash['B'])[0])
      elsif index % 4 == 2
        encrypted.push(first_rotation(character).rotate(shift_hash['C'])[0])
      elsif index % 4 == 3
        encrypted.push(first_rotation(character).rotate(shift_hash['D'])[0])
      end
      end
      # encrypted.insert(specials_hash.values[0], specials_hash.keys.to_s)

    hash_return(encrypted,key,date)
  end

  # def decrypt(message, key = key_generator, date = offset_generator)
  #   date = offset_generator(date) #need to deal with this
  #   shift_hash = shift(key, date)
  #   encrypted = []
  #   specials_hash = Hash.new(0)
  #   message.downcase.split("").each_with_index do |character, index|
  #       if !@alphabet.include?(character)
  #         specials_hash[character] = character.index
  #         require "pry"; binding.pry
  #       elsif index % 4 == 0
  #         encrypted.push(backwards_rotation(character).rotate(shift_hash['A'])[0])
  #       elsif index % 4 == 1
  #         encrypted.push(backwards_rotation(character).rotate(shift_hash['B'])[0])
  #       elsif index % 4 == 2
  #         encrypted.push(backwards_rotation(character).rotate(shift_hash['C'])[0])
  #       elsif index % 4 == 3
  #         encrypted.push(backwards_rotation(character).rotate(shift_hash['D'])[0])
  #       end
  #     end
  #   hash_return(encrypted,key,date)
  # end

  # def backwards_rotation(character)
  # #it cant be aplhabet, it has to be the new array
  #     index = (alphabet.index(character))
  #     require "pry"; binding.pry
  #    x = @alphabet.rotate(-index)
  # end

  def hash_return(encrypted,key,date)
    encryption_hash = {
       'encryption': encrypted.join,
       'key': key,
       'date': "040895"
     }
  end
end

