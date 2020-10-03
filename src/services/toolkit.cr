require "./toolkits/*"

abstract class Toolkit
  abstract def compile : Bool
  abstract def result : String
  abstract def generate_imports : String
  abstract def generate_styles : String
end
