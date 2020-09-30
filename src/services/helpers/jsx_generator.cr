module JSXGenerator
  private def generate_jsx(json_component, depth = 0) : String
    component = create_component(json_component)
    add_styles(component)
    add_imports(component)

    jsx = spaces(depth) # Generate spaces for formatting

    if component.children.size == 0 && !component.text?
      jsx += component.no_children_tag
      return jsx
    end

    jsx += component.open_tag
    jsx += component.text_with_depth(depth)

    component.children.each do |child|
      jsx += generate_jsx(json[child], depth + 2)
    end

    jsx += spaces(depth) # Generate spaces for formatting
    jsx += component.close_tag
  end

  private def add_styles(component)
    @raw_styles[component.style_name] = component.props
  end

  private def add_imports(component)
    @raw_imports << component.type
  end
end