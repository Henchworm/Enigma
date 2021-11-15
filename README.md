# Enigma
Final project, Turing School BEE 2110 
SELF EVALUATION 

Functionality: 3 
Enigma encrypts and decrypts, runs from command line interface. encrypt.rb reads .txt file, encrypts it and writes the result to new file specified by the user. The user is given the date and key, that they can use to run decrypt.rb which reads the encrypted message, decrypts and writes to a new file specified by the user. 

OOP: 3.5 
Two modules are used: Generator module to handle keys/offsets/shifts, and Formatter module to handle printing results/special chars formatting. Methods adhere to SRP. 

Ruby Conventions and Mechanics: 3 
Enigma.rb is short, some long methods/lines but nothing above 13 lines. Specials formatting approach could be more efficient. 

TDD: 3 Every line of code is tested, random outputs are tested. Simplecov running at 100%. Everything was build through TDD and each method has a single responsibility which is tested thoroughly. 

