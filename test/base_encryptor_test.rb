require_relative "test_helper"
require_relative "../lib/base_encryptor"

class BaseEncryptorTest < Minitest::Test
  def test_it_has_todays_date
    date = Date.today.strftime("%d%m%y")

    assert_equal date, BaseEncryptor.new.date
  end

  def test_it_makes_a_key
    key = /^\d{5}$/

    assert key.match(BaseEncryptor.new.key), "Key was too long or too short"
  end

  def test_it_loads_a_file
    message_text = "wow. such doge"
    input_file = "test/test_message.txt"

    new_encrypter = BaseEncryptor.new(input_file)

    assert_equal message_text, new_encrypter.input_text
  end

  def test_it_writes_a_file

  end
end

