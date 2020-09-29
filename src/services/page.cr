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

  def generate_jsx(json_component, depth = 0) : String
    component = create_component(json_component)
    add_styles(component)
    add_imports(component)

    jsx = generate_space_depth(depth) # Generate spaces for formatting

    if component.children.size == 0 && !component.text?
      jsx += component.no_children_tag
      return jsx
    end

    jsx += component.open_tag

    component.children.each do |child|
      jsx += generate_jsx(json[child], depth + 2)
    end

    jsx += generate_space_depth(depth) # Generate spaces for formatting
    jsx += component.close_tag
  end

  def generate_space_depth(depth : Int32) : String
    spaces = ""
    depth.times do
      spaces += " "
    end

    spaces
  end

  def generate : Bool
    contents = generate_jsx(json["ROOT"], depth: 6)
    @contents = contents[0..-2] # Remove the final line break
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

  # Returns something like:
  # Typography,
  # Container,
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

  # Returns the same as `Page#generate_style but multiple
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

  # Returns something like:
  # 'Container-1253': {
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
    formatted_style = "  '#{style}': {\n"

    @styles[style].each do |key, value|
      value = convert_value_to_hash(value)
      unless value.is_a? Hash(String, JSON::Any)
        value = convert_value_to_array(value)
      end

      formatted_style += format_style(key, value)
    end

    formatted_style += "  },\n"
  end

  # returns something like "    height: 'auto',\n"
  private def format_style(key : String, value : JSON::Any)
    "    #{key}: '#{value}',\n"
  end

  # returns something like "    background: rgba(255, 0, 0, 0.3 ),\n"
  private def format_style(key : String, value : Hash(String, JSON::Any))
    style = "    #{key}: rbga("
    value.each do |_, v|
      style += "#{v}, "
    end

    style = style[0..-3] # Remove the last `, `
    style += "),\n"
  end

  # returns something like "    10px 10px 10px 10px \n"
  private def format_style(key : String, value : Array(JSON::Any)) : String
    style = "    #{key}: '"
    value.each do |i|
      style += "#{i}px "
    end

    style = style[0..-2] # Remove the last ` `
    style += "',\n"
  end

  # Values are JSON::Any but some need special formatting
  # This tries to convert the value to a hash for further processing
  private def convert_value_to_hash(value : JSON::Any)
    value.as_h
  rescue
    value
  end

  # Values are JSON::Any but some need special formatting
  # This tries to convert the value to a array for further processing
  private def convert_value_to_array(value : JSON::Any)
    value.as_a
  rescue
    value
  end
end
