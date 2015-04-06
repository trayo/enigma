require_relative "test_helper"
require_relative "../lib/base_encryptor"

class BaseEncryptorTest < Minitest::Test
  def setup
    File.write("./message.txt", "")
  end

  def test_it_loads_a_file
    message_text = "wow. such doge"
    input_file = "messages/test_message.txt"
    File.write(input_file, message_text)

    encrypter = BaseEncryptor.new(input_file, "")

    assert_equal message_text, encrypter.input_text
  end

  def teardown
    File.delete("messages/test_message.txt") if File.exist?("messages/test_message.txt")
    File.delete("message.txt") if File.exist?("message.txt")
  end
end

