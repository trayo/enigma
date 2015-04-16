require_relative "cli_base"

class CLIDecrypt < CLIBase
  def initialize(arguments)
    super(arguments)
  end

  def run
    if file_doesnt_exist? || ran_with_force?
      d = Decrypt.new(file_input, file_output, key, date)
      d.decrypt
      d.write_file
      Printer.file_created(d.file_output, key, d.date)
    else
      Printer.file_already_exists
    end
  end
end

