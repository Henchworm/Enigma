require 'date'
require_relative './generator'
require_relative './formatting'
class Enigma
  include Generator
  include Formatting
  attr_reader :alphabet,
              :encrypted
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def first_rotation(character)
     @alphabet.rotate(alphabet.index(character))
  end

  def encrypt(message, key = key_generator, date = Date.today)
    offset = offset_generator(date)
    shift_hash = shift(key, offset)
    encrypted = []
    pop_specials(message).each_with_index do |character, index|
        if index % 4 == 0
          encrypted.push(first_rotation(character).rotate(shift_hash['A'])[0])
        elsif index % 4 == 1
          encrypted.push(first_rotation(character).rotate(shift_hash['B'])[0])
        elsif  index % 4 == 2
          encrypted.push(first_rotation(character).rotate(shift_hash['C'])[0])
        elsif index % 4 == 3
          encrypted.push(first_rotation(character).rotate(shift_hash['D'])[0])
        end
    end
    insert_specials(encrypted, message) && hash_return_encrypt(encrypted,key,date)
  end

  def decrypt(message, key = key_generator, date = Date.today)
    offset = offset_generator(date)
    shift_hash = shift(key, offset)
    decrypted = []
    pop_specials(message).each_with_index do |character, index|
        if index % 4 == 0
          decrypted.push(first_rotation(character).rotate(-shift_hash['A'])[0])
        elsif index % 4 == 1
          decrypted.push(first_rotation(character).rotate(-shift_hash['B'])[0])
        elsif  index % 4 == 2
          decrypted.push(first_rotation(character).rotate(-shift_hash['C'])[0])
        elsif index % 4 == 3
          decrypted.push(first_rotation(character).rotate(-shift_hash['D'])[0])
        end
    end
    insert_specials(decrypted, message) && hash_return_decrypt(decrypted,key,date)
  end
end
