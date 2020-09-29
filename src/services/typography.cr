class Typography < Component
  include JsonComponent

  getter json : JSON::Any

  def initialize(json : JSON::Any)
    @json = json
  end

  private def template
    "#{Rails.root}/app/jsx/text.tsx.erb"
  end
end
