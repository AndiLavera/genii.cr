require "kilt"
require "kilt/ecr"

class Page
  getter json : JSON::Any
  getter contents : String?

  def initialize(json)
    @json = JSON.parse(json)
    @styles = {} of String => Hash(String, JSON::Any)
    @imports = [] of String
  end

  def generate_jsx(json_component) : String
    component = create_component(json_component)
    add_styles(component)
    add_imports(component)

    return component.no_children_tag if component.children.size == 0 && !component.text?

    jsx = component.open_tag
    component.children.each do |child|
      jsx += generate_jsx(json[child])
    end

    jsx += component.close_tag
  end

  def generate : Bool
    @contents = generate_jsx(json["ROOT"])
    !!File.write("test.jsx", result)
  end

  private def result : String
    Kilt.render("src/jsx/page.tsx.ecr")
  end

  private def template : String
    "../jsx/page.tsx.erb"
  end

  private def create_component(json_component) : Component
    Component.subclasses[json_component["type"]["resolvedName"]].new(json_component)
  end

  private def add_styles(component)
    @styles[component.style_name] = component.props
  end

  private def add_imports(component)
    @imports << component.type
  end

  private def generate_imports : String
    formatted_imports = ""
    size = @imports.uniq.size

    @imports.uniq.each_with_index do |import, idx|
      formatted_imports += "#{import},"
      # Prevent last line from adding a new line
      formatted_imports += "\n  " unless idx == (size - 1)
    end

    formatted_imports
  end

  private def generate_styles : String
    formatted_styles = ""

    @styles.keys.each do |style|
      # Prevent 'text' from being a key
      # Props should go in each component and not return text. We can remove this line after that fact
      next if @styles[style].size == 1 && @styles[style]["text"]?
      formatted_styles += generate_style(style)
    end

    formatted_styles
  end

  private def generate_style(style : String) : String
    formatted_style = "  '#{style}': {\n"

    @styles[style].each do |key, value|
      # TODO: Better way of generating styles
      # Cannot process arrays or hashes
      # Padding, bg-color, margin, etc are messed up
      formatted_style += "    #{key}: '#{value}',\n"
    end

    formatted_style += "  },\n"
  end
end
