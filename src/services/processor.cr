require "./helpers/*"

module Processor
  include Dictionary
  include TypeConverter
  include StylesGenerator
  include ImportsGenerator
  include JSXGenerator

  private def remove_trailing_n_chars(value, n : Int32) : String
    value[0...-n]
  end
end
