require_relative "test_helper"
require_relative "../lib/decrypt"

class DecryptTest < Minitest::Test
  attr_reader :decrypter

  def setup
    srand 1234

    input_file = "test/test_encrypted.txt"
    output_file = "test/test_decrypted.txt"
    message = "b4ajt4r96irm7ps"
    key = "98765"
    date = "040415"

    File.delete(output_file) if File.exist?(output_file)
    File.delete(input_file) if File.exist?(input_file)
    File.write(input_file, message)

    @decrypter = Decrypt.new(input_file, output_file, key, date)
  end

  def test_it_decrypts_text_from_a_file
    expected_message = "star trek rules"

    assert_equal expected_message, decrypter.decrypt_message
  end

  def test_it_writes_the_decrypted_text_to_a_file
    expected_message = "star trek rules"

    decrypter.decrypt_message
    decrypter.write_file

    decrypted_output = File.read("./test/test_decrypted.txt").chomp
    assert_equal expected_message, decrypted_output
  end
end
