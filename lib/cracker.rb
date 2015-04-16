require_relative "rotator"
require_relative "cli_cracker"

class Cracker
  KNOWN_MESSAGE = "..end.."

  attr_reader :date,
              :encrypted_message,
              :cracked_message,
              :cracked_key,
              :file_output

  def initialize(file_input, file_output, date)
    @encrypted_message = load_file(file_input)
    @date = date
    @file_output = file_output
    @cracked_message = ""
    @cracked_key = ""
    @rotator = Rotator.new("00000", date, decrypt: true)
  end

  def crack
    "10000".upto("99999") do |key|
      rotations = create_rotations(key)
      result = @rotator.rotate_phrase(encrypted_message, rotations)
      break if check_results(result, key)
    end
  end

  def write_file
    File.write("./#{@file_output}", "#{@cracked_message}\n")
  end

  private

  def check_results(result, key)
    if result[-7..-1] == KNOWN_MESSAGE
      @cracked_message = result
      @cracked_key = key
      true
    end
  end

  def create_rotations(key)
    [
      -key[0..1].to_i,
      -key[1..2].to_i,
      -key[2..3].to_i,
      -key[3..4].to_i
    ]
  end

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end
end

if ARGV.first.include?("test")
  print ""
elsif ARGV.size < 3
  Printer.not_enough_cracker_arguments
else
  CLICraker.new(ARGV).run
end

