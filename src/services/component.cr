abstract class Component
  abstract def initialize(json : JSON::Any)

  macro subclasses
    {
    {% for subclass in @type.subclasses %}
      "#{{{subclass}}}" => {{subclass.id}},
    {% end %}
    }
  end

  # def open_tag
  #   component.open_tag(style_name)
  # end

  # def close_tag
  #   component.close_tag
  # end

  # def no_children_tag
  #   component.no_children_tag(style_name)
  # end
end
