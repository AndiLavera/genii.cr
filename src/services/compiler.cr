require "kilt"
require "kilt/ecr"
require "./toolkit"

class Genii::Compiler
  getter toolkit_type : Symbol
  getter toolkit : Toolkit

  def initialize(json : JSON::Any)
    @toolkit_type = :material_ui
    @toolkit = initialize_toolkit(json)
  end

  def compile : Bool
    @toolkit.compile
  end

  private def initialize_toolkit(json : JSON::Any)
    case toolkit_type
    when :material_ui
      MaterialUI.new(json)
    else
      raise "No Toolkit Found"
    end
  end
end
