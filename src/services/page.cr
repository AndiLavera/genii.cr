require "kilt"
require "kilt/ecr"
require "./string_processor"

class Page
  include StringProcessor

  getter json : JSON::Any
  getter contents : String?
  getter styles : String?
  getter imports : String?

  def initialize(json)
    @json = JSON.parse(json)
    @raw_styles = {} of String => Hash(String, JSON::Any)
    @raw_imports = [] of String
  end

  def generate : Bool
    contents = generate_jsx(json["ROOT"], depth: 6)
    @contents = remove_trailing_n_chars(contents, 1) # Remove the final line break

    @styles = generate_styles
    @imports = generate_imports

    !!(File.write("page.jsx", result))
  end

  private def result : String
    Kilt.render("src/jsx/page.tsx.ecr")
  end

  private def generate_imports : String
    generate_imports!
  end

  private def generate_styles : String
    generate_styles!
  end
end
