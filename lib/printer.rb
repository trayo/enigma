class Printer

  def self.not_enough_encrypt_arguments
    print "Please supply two arguments like:\n" +
          "'$ ruby ./lib/encrypt.rb message.txt encrypted.txt'\n"
  end

  def self.not_enough_decrypt_arguments
    print "Please supply four arguments like:\n" +
          "'$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt key date'\n"
  end

  def self.file_created(file_output, key, date)
    print "Created '#{file_output}' with the key #{key} and date #{date}.\n"
  end

  def self.file_already_exists
    print "File already exists.\n"
    print "Would you like to [c]ancel the operation or [o]verwrite the file?\n"
    print "> "
  end

  def self.exit_message
    print "Exiting without writing.\n"
  end

  def self.invalid_input
    print "Invalid input. Please try again:\n"
    print "> "
  end
end

