class Rotator
  attr_reader :key, :date, :rotations, :offsets

  CHARACTER_MAP = [*("a".."z"), *("0".."9"), " ", ".", ","].flatten

  def self.rotate_character(char, rotation, offset)
    new.rotate_character(char, rotation, offset)
  end

  def initialize(key = "00000", date = "000000", mode = {})
    raise "Key or date wasn't a string" if key_or_date_not_string(key, date)

    @key, @date = key, date
    @rotations, @offsets = [], []
    if mode[:decrypt]
      make_reverse_rotations_and_offsets
    else
      make_rotations_and_offsets
    end
  end

  def rotate_phrase(string, rotations = @rotations)
    i = 100
    string.chars.map do |char|
      i >= 3 ? i = 0 : i += 1
      rotate_character(char, rotations[i], offsets[i])
    end.join
  end

  def rotate_character(char, rotation, offset)
    CHARACTER_MAP.rotate(rotation + offset + CHARACTER_MAP.index(char)).first
  end

  private

  def make_rotations_and_offsets
    @rotations = make_rotations
    @offsets   = make_offsets
  end

  def make_reverse_rotations_and_offsets
    @rotations = make_rotations.map { |n| -n }
    @offsets   = make_offsets.map { |n| -n }
  end

  def make_rotations
    4.times.reduce([]) { |result, i| result << key[i..(i+1)].to_i }
  end

  def make_offsets
    (date.to_i ** 2).to_s.chars.pop(4).map(&:to_i)
  end

  def key_or_date_not_string(key, date)
    !key.is_a?(String) || !date.is_a?(String)
  end
end

