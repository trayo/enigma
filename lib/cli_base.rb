require_relative "printer"

class CLIBase
  attr_reader :file_input,
              :file_output,
              :key,
              :date,
              :force_option

  def initialize(arguments)
    @file_input = arguments[0]
    @file_output = arguments[1]
    @key = arguments[2]
    @date = arguments[3]
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

