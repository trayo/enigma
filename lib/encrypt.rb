require_relative "base_encryptor"
require_relative "printer"

class Encrypt < BaseEncryptor
  def initialize(file_input, file_output, key = generate_key)
    super(file_input, file_output)
    @key = key
    @rotator = Rotator.new(key, date)
  end

  def encrypt
    rotate_message
  end

  private

  def generate_key
    rand(10000..99999).to_s
  end
end

@file_input = ARGV[0]
@file_output = ARGV[1]
@key = ARGV[2]
@force_option = ARGV.last

def encrypt_and_write_file(e)
  e.encrypt
  e.write_file
  Printer.file_created(e.file_output, e.key, e.date)
end

def ran_with_force?
  @force_option == "force" || @force_option == "-f"
end

def supplied_a_key?
  @key =~ /^\d{5}$/
end

def file_doesnt_exist?
  !File.exist?(@file_output)
end

if ARGV.size < 2
  Printer.not_enough_encrypt_arguments

elsif file_doesnt_exist? && !@key
  e = Encrypt.new(@file_input, @file_output)
  encrypt_and_write_file(e)

elsif file_doesnt_exist? && supplied_a_key?
  e = Encrypt.new(@file_input, @file_output, @key)
  encrypt_and_write_file(e)

elsif ran_with_force? && supplied_a_key?
  e = Encrypt.new(@file_input, @file_output, @key)
  encrypt_and_write_file(e)

elsif ran_with_force?
  e = Encrypt.new(@file_input, @file_output)
  encrypt_and_write_file(e)

else
  Printer.file_already_exists
end

