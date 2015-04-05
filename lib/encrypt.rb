require_relative "rotator"

class Encrypt
  attr_reader :key, :date

  def initialize(key, date)
    @key = key
    @date = date
  end
end
