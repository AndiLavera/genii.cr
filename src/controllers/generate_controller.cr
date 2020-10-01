class GenerateController < ApplicationController
  def create
    page = Genii::Compiler.new(page_params.validate!["page"].not_nil!)
    page.compile
  end

  def page_params
    params.validation do
      required(:page)
    end
  end
end
