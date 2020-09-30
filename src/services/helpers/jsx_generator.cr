module JSXGenerator
  private def generate_jsx(json_component, depth = 0) : String
    component = create_component(json_component)
    add_raw_info(component)
    jsx = spaces(depth) # Generate spaces for formatting

    return jsx += component.no_children_tag if no_children?(component)

    jsx += open_tag(component, depth)
    jsx += add_children_jsx(component, depth)
    close_tag(jsx, component, depth)
  end

  private def create_component(json_component) : JsonComponent
    JsonComponent.new(json_component)
  end

  private def add_raw_info(component : JsonComponent)
    add_raw_styles(component)
    add_raw_imports(component)
  end

  private def add_raw_styles(component : JsonComponent)
    @raw_styles[component.style_name] = component.props
  end

  private def add_raw_imports(component : JsonComponent)
    @raw_imports << component.type
  end

  private def open_tag(component : JsonComponent, depth : Int32) : String
    jsx = component.open_tag
    jsx += component.text_with_depth(depth)
  end

  private def close_tag(jsx : String, component : JsonComponent, depth : Int32) : String
    jsx += spaces(depth) # Generate spaces for formatting
    jsx += component.close_tag
  end

  private def no_children?(component : JsonComponent) : Bool
    component.children.size == 0 && !component.text?
  end

  private def add_children_jsx(component : JsonComponent, depth : Int32) : String
    jsx = ""
    component.children.each do |child|
      jsx += generate_jsx(json[child], depth + 2)
    end

    jsx
  end
end