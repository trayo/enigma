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

CLIEncrypt.new(ARGV).run

