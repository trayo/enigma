require_relative "test_helper"
require_relative "../lib/cracker"

class CrackerTest < Minitest::Test
  attr_reader :input_file, :output_file

  def setup
    @input_file = "messages/test_encrypted.txt"
    @output_file = "messages/test_cracked.txt"
    encrypted_message = "5rrn.17n52nsrkp49o1bkllu0qlo"

    File.delete(output_file) if File.exist?(output_file)
    File.delete(input_file) if File.exist?(input_file)
    File.write(input_file, encrypted_message)
  end

  def test_it_cracks_a_message
    expected_output = "see you space cowboy ..end.."
    expected_key = "11111"
    date = "070415"

    cracker = Cracker.new(input_file, output_file, date)
    cracker.crack

    assert_equal expected_output, cracker.cracked_message
    assert_equal expected_key, cracker.cracked_key
  end

  def teardown
    File.delete(input_file) if File.exist?(input_file)
  end
end

