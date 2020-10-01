module StylesGenerator
  # Returns the same as `StylesGenerator#generate_style but multiple
  private def generate_styles! : String
    formatted_styles = ""

    @raw_styles.keys.each do |style|
      formatted_styles += generate_style(style)
    end

    remove_trailing_n_chars(formatted_styles, 1) # Remove the trailing `\n`
  end

  # Returns something like:
  # Container_1253: {
  #   flexDirection: 'column',
  #   alignItems: 'flex-start',
  #   justifyContent: 'flex-start',
  #   fillSpace: 'no',
  #   padding: '40px 40px 40px 40px',
  #   margin: '0px 0px 0px 0px',
  #   background: rbga(255, 255, 255, 1),
  #   color: rbga(0, 0, 0, 1),
  #   width: '800px',
  #   height: 'auto',
  # },
  private def generate_style(style : String) : String
    # "  '#{style}': {\n"
    formatted_style = spaces(2) + style + colon + space + open_bracket + new_line

    @raw_styles[style].each do |key, value|
      next if key === "api" || key === "styles" || key === "text"

      value = to_h(value)
      value = to_a(value) unless value.is_a? Hash(String, JSON::Any)

      formatted_style += format_style(key, value)
    end

    # "  },\n"
    formatted_style += spaces(2) + close_bracket + comma + new_line
  end

  # returns something like "    height: 'auto',\n"
  private def format_style(key : String, value : JSON::Any) : String
    # "    #{key}: '#{value}',\n"
    spaces(4) + key.to_s + colon + space + single_quotes(value) + comma + new_line
  end

  # returns something like "    background: rgba(255, 0, 0, 0.3),\n"
  private def format_style(key : String, value : Hash(String, JSON::Any)) : String
    return "" if value.empty?

    # "    #{key}: 'rbga("
    style = spaces(4) + key.to_s + colon + space + single_quote + rgba + open_parenthesis
    value.each do |_, v|
      # "#{v}, "
      style += v.to_s + comma + space
    end

    style = remove_trailing_n_chars(style, 2) # Remove the trailing `, `
    # ")',\n"
    style += close_parenthesis + single_quote + comma + new_line
  end

  # returns something like "    10px 10px 10px 10px \n"
  private def format_style(key : String, value : Array(JSON::Any)) : String
    return "" if value.map(&.to_s) == ["0", "0", "0", "0"]

    # "    #{key}: '"
    style = spaces(4) + key.to_s + colon + space + single_quote
    value.each do |i|
      # "#{i}px "
      style += i.to_s + px + space
    end

    style = remove_trailing_n_chars(style, 1) # Remove the trailing ` `
    # "',\n"
    style += single_quote + comma + new_line
  end
end