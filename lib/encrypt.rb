require 'date'
require_relative "rotator"

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
    File.write("./#{file_output}", encrypted_message)
    puts "Created '#{file_output}' with the key #{key} and date #{date}"
  end

  private

  def load_file(file_path)
    File.read("./#{file_path}").chomp
  end

  def generate_key
    rand(11111..99999).to_s
  end

  def generate_date
    Date.today.strftime("%d%m%y")
  end
end

if ARGV.size < 2
  puts "Please supply two arguments like:"
  puts "'$ ruby ./lib/encrypt.rb message.txt encrypted.txt'"
else
  e = Encrypt.new(ARGV[0], ARGV[1])
  e.encrypt_message
  e.write_file
end
