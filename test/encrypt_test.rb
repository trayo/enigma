require_relative "test_helper"
require_relative "../lib/encrypt"

class EncryptTest < Minitest::Test
  attr_reader :encrypter

  def setup
    srand 1234
    input_path = "test/message.txt"
    output_path = "test/encrypted.txt"

    File.delete(output_path) if File.exist?(output_path)

    @encrypter = Encrypt.new(input_path, output_path)
  end

  def test_it_has_todays_date
    date = Date.today.strftime("%d%m%y")

    assert_equal date, Encrypt.new.date
  end

  def test_it_makes_a_key
    key = /^\d{5}$/

    assert key.match(Encrypt.new.key), "Key was too long or too short"
  end

  def test_it_loads_a_file
    message_text = "wow. such doge"
    input_path = "test/message.txt"

    new_encrypter = Encrypt.new(input_path)

    assert_equal message_text, new_encrypter.unencrypted_message
  end

  def test_it_encrypts_text_from_a_file
    expected_encryption = "p3cd37ahamwt,t"

    assert_equal expected_encryption, encrypter.encrypt_message
  end

  def test_it_writes_the_encrypted_text_to_a_file
    expected_output = "69178\np3cd37ahamwt,t"

    encrypter.encrypt_message
    encrypter.write_file

    encrypted_output = File.read("./test/encrypted.txt").chomp
    assert_equal expected_output, encrypted_output
  end
end

