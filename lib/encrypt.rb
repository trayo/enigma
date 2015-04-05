require "date"
require_relative "rotator"
require_relative "printer"

class Encrypt
  attr_reader :unencrypted_message,
              :file_output,
              :key,
              :date,
              :encrypted_message

  def initialize(file_input = "message.txt", file_output = "encrypted.txt")
    @unencrypted_message = load_file(file_input)
    @encrypted_message   = ""
    @file_output         = file_output
    @key                 = generate_key
    @date                = generate_date
    @rotator             = Rotator.new(key, date)
  end

  def encrypt_message
    @encrypted_message = @rotator.rotate_phrase(unencrypted_message)
  end

  def write_file
    if File.exist?(file_output)
      Printer.file_already_exists
      ask_user_if_they_want_to_overwrite_file
    else
      Printer.file_created(file_output, key, date)
      File.write("./#{file_output}", "#{key}\n#{encrypted_message}")
    end
  end

  private

  def ask_user_if_they_want_to_overwrite_file
    get_user_input

    while !overwrite? || !cancel?
      if overwrite?
        Printer.file_created(file_output, key, date)
        File.write("./#{file_output}", "#{key}\n#{encrypted_message}")
        exit
      elsif cancel?
        Printer.exit_message
        exit
      else
        Printer.invalid_input
        get_user_input
      end
    end
  end

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end

  def generate_key
    rand(11111..99999).to_s
  end

  def generate_date
    Date.today.strftime("%d%m%y")
  end

  def get_user_input
    @input = $stdin.gets.downcase.chomp
  end

  def overwrite?
    @input == "o" || @input == "overwrite"
  end

  def cancel?
    @input == "c" || @input == "cancel"
  end
end

if ARGV.size < 2
  Printer.not_enough_arguments
else
  e = Encrypt.new(ARGV[0], ARGV[1])
  e.encrypt_message
  e.write_file
end

