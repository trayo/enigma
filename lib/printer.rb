class Printer

  def self.not_enough_encrypt_arguments
    print "Please supply two arguments like:\n"
    print "'#{command_line_example}'\n"
  end

  def self.not_enough_decrypt_arguments
    print "Please supply four arguments like:\n"
    print "'#{command_line_example}'\n"
  end

  def self.file_created(file_output, key, date)
    print "Created '#{file_output}' with the key #{key} and date #{date}.\n"
  end

  def self.file_already_exists
    print "File already exists.\n"
    print "Run with 'force' or '-f':\n"
    print "'#{command_line_example} force'\n"
    print "'#{command_line_example} -f'\n"
  end

  def self.exit_message
    print "Exiting without writing.\n"
  end

  def self.invalid_input
    print "Invalid input. Please try again:\n"
    print "> "
  end

  def self.command_line_example
    "$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt key date"
  end

  private_class_method :command_line_example
end

