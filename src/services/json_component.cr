require "random"

module JsonComponent
  def type
    json["type"]["resolvedName"].as_s
  end

  def canvas? : Bool
    json["isCanvas"].as_bool
  end

  def props : Hash(String, JSON::Any)
    json["props"].as_h
  end

  def text : String?
    (text = json["props"]["text"]?) ? text.as_s : nil
  end

  def text? : Bool
    !!json["props"]["text"]?
  end

  def display_name : String
    json["displayName"].as_s
  end

  def custom : JSON::Any
    json["custom"]
  end

  def hidden : Bool
    json["hidden"].as_bool
  end

  def nodes : Array(String)
    json["nodes"].as_a.map(&.as_s)
  end

  def children : Array(String)
    nodes
  end

  def linked_nodes : Array(String)
    json["linkedNodes"].as_a.map(&.as_s)
  end

  def style_name : String
    @style_name ||= "#{type}-#{Random::Secure.rand(10_000)}"
  end

  def open_tag : String
    if props.size == 0 && text.nil?
      "<#{type}>"
    else
      tag = "<#{type} className={classes[`#{style_name}`]}>\n"
      tag += "#{text}\n" if text?
      tag
    end
  end

  def close_tag : String
    "</ #{type}>\n"
  end

  def no_children_tag : String
    if props.size == 0
      "<#{type} />\n"
    else
      "<#{type} className={classes[`#{style_name}`]} />\n"
    end
  end
end
