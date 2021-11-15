require './enigma'

enigma = Enigma.new
unencrypted = ARGV[0]
encrypted = ARGV[1]


message_file = File.read(unencrypted, chomp:true)

File.open(encrypted, "w") do |file|
  print_message = enigma.encrypt(message_file)
    file.puts print_message[:encryption]
    puts "Created #{encrypted} with the key #{print_message[:key]} and date #{print_message[:date]}"
end

