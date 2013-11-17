class RegionsController < ApplicationController
  layout 'clean'
  def index


  end


  def list
    areas = Area.all.inject([]) do |areas_arr, area|
      stim_area = area.attributes
      stim_area.merge!({
                           upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           size: Forgery(:basic).number(:at_least => 200000, :at_most => 3000000),
                           downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25),
                           count: Forgery(:basic).number(:at_least => 5, :at_most => 25)})

      areas_arr << {name: area.name, children: [stim_area]}
    end

    render json: {name: 'Areas', children: areas}
  end
end
