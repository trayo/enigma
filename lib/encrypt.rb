require_relative "base_encryptor"
require_relative "cli_encrypt"

class Encrypt < BaseEncryptor
  def initialize(file_input, file_output, key = generate_key)
    super(file_input, file_output)
    @key = key
    @rotator = Rotator.new(key, date)
  end

  def encrypt
    rotate_message
  end

  private

  def generate_key
    rand(10000..99999).to_s
  end
end

if ARGV.first.include?("test")
  print ""
elsif ARGV.size < 2
  Printer.not_enough_encrypt_arguments
else
  CLIEncrypt.new(ARGV).run
end

