module Dictionary
  def px : String
    "px"
  end

  def comma : String
    ","
  end

  def new_line : String
    "\n"
  end

  def space : String
    " "
  end

  def spaces(num : Int32) : String
    spaces = ""
    num.times { spaces += " " }
    spaces
  end

  def single_quote : String
    "'"
  end

  def single_quotes(value) : String
    "'#{value}'"
  end

  def double_quotes(value : String | JSON::Any) : String
    "\"#{value}\""
  end

  def colon : String
    ":"
  end

  def semi_colon : String
    ";"
  end

  def open_parenthesis : String
    "("
  end

  def close_parenthesis : String
    ")"
  end

  def open_bracket : String
    "{"
  end

  def close_bracket : String
    "}"
  end

  def rgba : String
    "rgba"
  end
end
