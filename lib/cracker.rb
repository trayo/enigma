require "rotator"

class Cracker
  KNOWN_MESSAGE = "..end.."

  attr_reader :message,
              :date,
              :end_message

  def initialize(file_input, file_output, date)
    @encrypted_message = load_file(file_input)
    @date = date
    @output = file_output
    @end_message = @encrypted_message.chars.last(7).join
    @cracked_message = ""
    @cracked_key = ""
  end

  def crack
    "11111".upto("99999") do |key|
      result = Rotator.new(key, date).rotate_phrase(end_message)

      if key == "25641"
        require "pry"; binding.pry
      end
      if result == KNOWN_MESSAGE
        @cracked_message = result
        @cracked_key = key
        require "pry"; binding.pry
        break
      end
    end
  end

  private

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end
end

