require_relative "base_encryptor"

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

if ARGV.size < 4
  Printer.not_enough_decrypt_arguments
elsif File.exist?(ARGV[1]) && ARGV[4] == "force" || ARGV[4] == "-f"
  d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
  d.decrypt
  d.write_file
  Printer.file_created(d.file_output, ARGV[2], ARGV[3])
else
  Printer.file_already_exists
end

