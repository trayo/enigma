require_relative "printer"

class CLIBase

  def initialize(arguments)
    @arguments = arguments
    @file_input = arguments[0]
    @file_output = arguments[1]
    @key = arguments[2]
    @force_option = arguments.last
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
end

