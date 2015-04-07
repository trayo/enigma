require "date"
require_relative "rotator"

class BaseEncryptor
  attr_reader :input_text,
              :file_output,
              :key,
              :date,
              :rotated_text

  def initialize(file_input, file_output)
    @input_text   = load_file(file_input)
    @file_output  = file_output
    @date         = generate_date
    @rotated_text = ""
  end

  def rotate_message
    @rotated_text = @rotator.rotate_phrase(input_text)
  end

  def write_file
    File.write("./#{file_output}", "#{@rotated_text}\n")
  end

  private

  def generate_date
    Date.today.strftime("%d%m%y")
  end

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end
end

