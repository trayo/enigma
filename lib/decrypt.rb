require_relative "base_encryptor"
require_relative "cli_decrypt"

class Decrypt < BaseEncryptor
  def initialize(file_input, file_output, key, date)
    raise "Invalid key or date" if not_valid_key(key) || not_valid_date(date)

    super(file_input, file_output)
    @rotator = Rotator.new(key, date, decrypt: true)
  end

  def decrypt
    rotate_message
  end

  private

  def not_valid_key(key)
    key !~ /^\d{5}$/
  end

  def not_valid_date(date)
    date !~ /^\d{6}$/
  end
end

if ARGV.first.include?("test")
  print ""
elsif ARGV.size < 4
  Printer.not_enough_decrypt_arguments
else
  CLIDecrypt.new(ARGV).run
end

