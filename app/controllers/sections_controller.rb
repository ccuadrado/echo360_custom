class SectionsController < ApplicationController
  include SectionsHelper
  
  def show
    @title = "Section"
  
    @section = Section.find(params[:id])
    get_section(@section)
    @section = Section.find(params[:id])
  end

end
