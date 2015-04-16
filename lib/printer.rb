class Printer

  def self.not_enough_encrypt_arguments
    puts "\nError: Not enough arguments"
    puts "Please supply two arguments like:"
    print "$ ruby lib/encrypt.rb message.txt encrypted.txt"
    puts "Or three if you wish to specify a key:"
    puts "$ ruby lib/encrypt.rb message.txt encrypted.txt key"
  end

  def self.not_enough_decrypt_arguments
    puts "\nError: Not enough arguments"
    print "Please supply four arguments like:\n"
    print "$ ruby lib/decrypt.rb decrypted.txt encrypted.txt key date\n"
  end

  def self.not_enough_cracker_arguments
    puts "\nError: Not enough arguments"
    print "Please supply three arguments like:\n"
    print "$ ruby lib/cracker.rb encrypted.txt cracked.txt date\n"
  end

  def self.file_created(file_output, key, date)
    print "\nCreated '#{file_output}' with the key #{key} and date #{date}.\n"
  end

  def self.file_already_exists
    print "\nFile already exists.\n"
    print "Run with 'force' or '-f':\n"
    print "'#{command_line_example} force'\n"
    print "'#{command_line_example} -f'\n"
  end

  def self.command_line_example
    "$ ruby lib/decrypt.rb encrypted.txt decrypted.txt key date"
  end

  private_class_method :command_line_example
end

