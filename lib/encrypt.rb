require_relative "base_encrypter"

class Encrypt < BaseEncrypter
  def initialize(file_input, file_output)
    super(file_input, file_output)

    @rotator = Rotator.new(key, date)
  end

  def encrypt_message
    rotate_message
  end
end

if ARGV.size < 2
  Printer.not_enough_arguments
else
  e = Encrypt.new(ARGV[0], ARGV[1])
  e.encrypt_message
  e.write_file
  Printer.file_created(e.file_output, e.key, e.date)
end

