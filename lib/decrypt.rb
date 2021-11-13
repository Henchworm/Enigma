require './enigma'

enigma = Enigma.new
encrypted_file = ARGV[0]
decrypted_file  = ARGV[1]
key = ARGV[2]
date = ARGV[3]

encrypted_file = File.new(encrypted_file).read

File.open(decrypted_file, "w") do |file|
    print_message = enigma.decrypt(encrypted_file, key, date)
    file.puts print_message[:decryption]
    puts "Created #{decrypted_file} with the key #{key} and date #{date}"
end