require_relative "cli_base"

class CLICraker < CLIBase
  def initialize(arguments)
    super(arguments)
    @date = arguments[2]
  end

  def run
    if @arguments.size < 3
      Printer.not_enough_cracker_arguments
    elsif file_doesnt_exist?
      c = Cracker.new(@file_input, @file_output, @date)
      crack_and_write_file(c)
    elsif ran_with_force?
      c = Cracker.new(@file_input, @file_output, @date)
      crack_and_write_file(c)
    else
      Printer.file_already_exists
    end
  end

  private

  def crack_and_write_file(c)
    c.crack
    c.write_file
    Printer.file_created(c.file_output, c.cracked_key, c.date)
  end

  def supplied_a_date?
    @date =~ /^\d{6}$/
  end
end
