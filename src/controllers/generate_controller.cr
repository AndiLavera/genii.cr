class GenerateController < ApplicationController
  def create
    page = Page.new(page_params.validate!["page"].not_nil!)
    page.generate
  end

  def page_params
    params.validation do
      required(:page)
    end
  end
end
