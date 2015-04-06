require "date"
require_relative "rotator"
require_relative "printer"

class BaseEncryptor
  attr_reader :input_text,
              :file_output,
              :key,
              :date,
              :rotated_text

  def initialize(file_input = "message.txt", file_output = "e.txt")
    @input_text  = load_file(file_input)
    @file_output = file_output
    @key         = generate_key
    @date        = generate_date
  end

  def rotate_message
    @rotated_text = @rotator.rotate_phrase(input_text)
  end

  def write_file
    File.write("./#{file_output}", "#{@rotated_text}\n")
  end

  private

  def generate_key
    rand(11111..99999).to_s
  end

  def generate_date
    Date.today.strftime("%d%m%y")
  end

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end
end

