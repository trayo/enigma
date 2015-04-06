require_relative "test_helper"
require_relative "../lib/cracker"

class CrackerTest < Minitest::Test
  attr_reader :input_file, :output_file

  def setup
    @input_file = "messages/test_encrypted.txt"
    @output_file = "messages/test_cracked.txt"
    encrypted_message = "3 1j.qhlg,y80i0 0kyfzxbkzr"

    File.delete(output_file) if File.exist?(output_file)
    File.delete(input_file) if File.exist?(input_file)
    File.write(input_file, encrypted_message)
  end

  def test_it_cracks_a_message
    expected_output = "crack test 1,2,3,4 ..end.."
    expected_key = "25641"
    date = "060415"

    cracker = Cracker.new(input_file, output_file, date)

    assert_equal expected_output, cracker.crack
    assert_equal expected_key, cracker.key
  end
end

