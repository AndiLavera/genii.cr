require "./json_component"

class Container < Component
  include JsonComponent

  getter json : JSON::Any

  def initialize(json : JSON::Any)
    @json = json
  end

  # def result
  #   ERB.new(File.read(template), trim_mode: '-').result
  # end

  def import
    "import { Container } from '@material-ui/core';"
  end

  private def template
    "#{Amber.root}/app/jsx/container.tsx.ecr"
  end
end
