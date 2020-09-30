module TypeConverter
  # Values are JSON::Any but some need special formatting
  # This tries to convert the value to a hash for further processing
  private def to_h(value : JSON::Any)
    value.as_h
  rescue
    value
  end

  # Values are JSON::Any but some need special formatting
  # This tries to convert the value to a array for further processing
  private def to_a(value : JSON::Any)
    value.as_a
  rescue
    value
  end
end