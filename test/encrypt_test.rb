require_relative "test_helper"
require_relative "../lib/encrypt"

class EncryptTest < Minitest::Test
  attr_reader :encrypter, :input_file, :output_file

  def setup
    srand 1234

    @input_file = "messages/test_message.txt"
    @output_file = "messages/test_encrypted.txt"
    message = "wow. such doge"

    File.delete(output_file) if File.exist?(output_file)
    File.delete(input_file) if File.exist?(input_file)
    File.write(input_file, message)

    @encrypter = Encrypt.new(input_file, output_file)
  end

  def test_it_encrypts_text_from_a_file
    expected_encryption = "os452w29,bli.i"

    assert_equal expected_encryption, encrypter.encrypt
  end

  def test_it_writes_the_encrypted_text_to_a_file
    expected_output = "os452w29,bli.i"

    encrypter.encrypt
    encrypter.write_file

    encrypted_output = File.read(output_file).chomp
    assert_equal expected_output, encrypted_output
  end

  def teardown
    File.delete(output_file) if File.exist?(output_file)
    File.delete(input_file) if File.exist?(input_file)
  end
end

