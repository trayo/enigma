class Rotator
  attr_reader :key, :date, :rotations, :offsets

  def self.rotate_character(char, rotation, offset)
    new.rotate_character(char, rotation, offset)
  end

  def self.map
    new.map
  end

  def initialize(key = "00000", date = "000000")
    @key, @date = key, date
    @rotations = make_rotations
    @offsets = make_offsets
  end

  def map
    [("a".."z").to_a, ("0".."9").to_a, " ", ".", ","].flatten
  end

  def rotate_character(char, rotation, offset)
    map.rotate(rotation + offset + map.index(char)).first
  end

  def rotate_phrase(string)
    i = 100
    string.chars.map do |char|
      i >= 3 ? i = 0 : i += 1
      rotate_character(char, rotations[i], offsets[i])
    end.join
  end

  def make_rotations
    4.times.reduce([]) { |result, i| result << key[i..(i+1)].to_i }
  end

  def make_offsets
    (date.to_i ** 2).to_s.chars.pop(4).map(&:to_i)
  end
end
