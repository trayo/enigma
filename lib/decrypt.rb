require_relative "base_encryptor"

class Decrypt < BaseEncryptor
  def initialize(file_input, file_output, key, date)
    super(file_input, file_output)

    @rotator = Rotator.new(key, date, decrypt: true)
  end

  def decrypt_message
    rotate_message
  end
end

if ARGV.size < 4
  Printer.not_enough_decrypt_arguments
else
  d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
  d.decrypt_message
  d.write_file
  Printer.file_created(d.file_output, d.key, d.date)
end

