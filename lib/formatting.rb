module Formatting

  def pop_specials(message)
    message.downcase.split('').find_all do |character|
      @alphabet.include?(character)
    end
  end

  def specials_arrays(message)
    specials = []
    message.downcase.split('').each_with_index do |character, index|
      if !@alphabet.include?(character)
        specials << (character + index.to_s).split
      end
    end
    specials
  end
  
  def insert_specials(encrypted, message)
    specials_arrays(message).each do |char|
      encrypted.insert(char[0][1..-1].to_i, char[0][0])
    end
    encrypted.join
  end

  def hash_return_encrypt(encrypted,key,date)
    encryption_hash = {
       'encryption': encrypted.join,
       'key': key,
       'date': date_formatter(date)
     }
  end

  def hash_return_decrypt(decrypted,key,date)
    encryption_hash = {
       'decryption': decrypted.join,
       'key': key,
       'date': date_formatter(date)
     }
  end

  def date_formatter(date)
    if date.class == Date
     formatted = date.strftime("%d,%m,%y").gsub(/,/, '')
    else
      date
    end
  end
end