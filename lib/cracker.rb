require_relative "rotator"

class Cracker
  KNOWN_MESSAGE = "..end.."

  attr_reader :date,
              :encrypted_message,
              :cracked_message,
              :cracked_key

  def initialize(file_input, file_output, date)
    @encrypted_message = load_file(file_input)
    @date = date
    @output = file_output
    @cracked_message = ""
    @cracked_key = ""
  end

  def crack
    rotator = Rotator.new("00000", date, decrypt: true)
    "10000".upto("99999") do |key|
      rotations = [-key[0..1].to_i, -key[1..2].to_i, -key[2..3].to_i, -key[3..4].to_i]
      result = rotator.rotate_phrase(encrypted_message, rotations)

      if result[-7..-1] == KNOWN_MESSAGE
        @cracked_message = result
        @cracked_key = key
        break
      end
    end
  end

  private

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end
end

