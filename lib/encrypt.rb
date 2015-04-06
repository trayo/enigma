require_relative "base_encryptor"

class Encrypt < BaseEncryptor
  def initialize(file_input, file_output)
    super(file_input, file_output)

    @rotator = Rotator.new(key, date)
  end

  def encrypt
    rotate_message
  end
end

if ARGV.size < 2
  Printer.not_enough_encrypt_arguments
elsif File.exist?(ARGV[1]) && ARGV[2] == "force" || ARGV[2] == "-f"
  e = Encrypt.new(ARGV[0], ARGV[1])
  e.encrypt
  e.write_file
  Printer.file_created(e.file_output, e.key, e.date)
else
  Printer.file_already_exists
end

