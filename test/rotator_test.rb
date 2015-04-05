require_relative "test_helper"
require_relative "../lib/rotator"

class RotatorTest < Minitest::Test
  def test_it_has_a_character_map
    expected_map = [("a".."z").to_a, ("0".."9").to_a, " ", ".", ","].flatten

    assert_equal expected_map, Rotator.map
  end

  def test_it_has_a_key_and_date
    key  = "41521"
    date = "020315"

    rotator = Rotator.new(key, date)

    assert_equal key, rotator.key
    assert_equal date, rotator.date
  end

  def test_it_makes_rotations
    key = "41521"
    expected_rotations = [41, 15, 52, 21]

    rotator = Rotator.new(key, "111111")

    assert_equal expected_rotations, rotator.rotations
  end

  def test_it_makes_offsets
    date = "020315"
    expected_offsets = [9, 2, 2, 5]

    rotator = Rotator.new("11111", date)

    assert_equal expected_offsets, rotator.offsets
  end

  def test_it_can_rotate_a_single_character
    rotation = 9
    offset = 1

    assert_equal "k", Rotator.rotate_character("a", rotation, offset)
  end

  def test_it_can_reverse_rotate_a_single_character
    rotation = -9
    offset = -1

    assert_equal "a", Rotator.rotate_character("k", rotation, offset)
  end

  def test_it_can_rotate_special_characters
    assert_equal "h", Rotator.rotate_character(" ", 9, 1)
    assert_equal "i", Rotator.rotate_character(".", 9, 1)
    assert_equal "j", Rotator.rotate_character(",", 9, 1)
  end

  def test_it_can_rotate_with_the_largest_numbers
    rotation = 99
    offset = 9

    assert_equal "d", Rotator.rotate_character("m", rotation, offset)
  end

  def test_it_can_rotate_a_character_given_a_key_and_date
    key = "99999"
    date = "020315"

    rotator = Rotator.new(key, date)

    assert_equal 99, rotator.rotations.first
    assert_equal 9, rotator.offsets.first
    assert_equal "d", rotator.rotate_phrase("m")
  end

  def test_it_rotates_a_phrase
    key = "54321"
    date = "040415"

    rotator = Rotator.new(key, date)

    assert_equal "auryoyp2yd.bxk", rotator.rotate_phrase("wow. such doge")
  end

  def test_it_reverse_rotates_a_phrase
    key = "54321"
    date = "040415"

    rotator = Rotator.new(key, date, {decrypt: true})

    assert_equal "wow. such doge", rotator.rotate_phrase("auryoyp2yd.bxk")
  end
end
