class BusinessCategoriesController < ApplicationController

  def index
    results = BusinessCategory.search(params[:term]).inject([]) do |cats, cat|
      cats << { value: cat[:name], id: cat[:id] }
    end
    render json: results
  end

end
