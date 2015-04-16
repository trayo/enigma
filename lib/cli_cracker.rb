require_relative "cli_base"

class CLICraker < CLIBase
  def initialize(arguments)
    super(arguments)
    @date = arguments[2]
  end

  def run
    if file_doesnt_exist? || ran_with_force?
      c = Cracker.new(file_input, file_output, date)
      c.crack
      c.write_file
      Printer.file_created(c.file_output, c.cracked_key, c.date)
    else
      Printer.file_already_exists
    end
  end

  private

  def supplied_a_date?
    @date =~ /^\d{6}$/
  end
end

