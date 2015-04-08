require_relative "cli_base"

class CLIDecrypt < CLIBase
  def initialize(arguments)
    super(arguments)

    @date = arguments[3]
  end

  def run
    if ARGV.size < 4
      Printer.not_enough_decrypt_arguments
    elsif file_doesnt_exist?
      d = Decrypt.new(@file_input, @file_output, @key, @date)
      decrypt_and_write_file(d)
    elsif ran_with_force?
      d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
      decrypt_and_write_file(d)
    else
      Printer.file_already_exists
    end
  end

  private

  def decrypt_and_write_file(d)
    d.decrypt
    d.write_file
    Printer.file_created(d.file_output, @key, d.date)
  end
end

