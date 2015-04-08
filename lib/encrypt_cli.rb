require_relative "base_cli"

class EncryptCLI < BaseCLI
  def initialize(arguments)
    super(arguments)
  end

  def run
    if @arguments.size < 2
      Printer.not_enough_encrypt_arguments
    elsif file_doesnt_exist? && supplied_a_key? || ran_with_force? && supplied_a_key?
      e = Encrypt.new(@file_input, @file_output, @key)
      encrypt_and_write_file(e)
    elsif ran_with_force?
      e = Encrypt.new(@file_input, @file_output)
      encrypt_and_write_file(e)
    else
      Printer.file_already_exists
    end
  end

  def encrypt_and_write_file(e)
    e.encrypt
    e.write_file
    Printer.file_created(e.file_output, e.key, e.date)
  end
end

