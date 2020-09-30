module ImportsGenerator
  # Returns something like:
  # Typography,
  # Container,
  private def generate_imports! : String
    formatted_imports = ""
    size = @raw_imports.uniq.size

    @raw_imports.uniq.each_with_index do |import, idx|
      # "#{import},\n  "
      formatted_imports += import.to_s + comma + new_line + spaces(2)
    end

    remove_trailing_n_chars(formatted_imports, 3)
  end
end