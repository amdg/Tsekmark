class RegionsController < ApplicationController
  layout 'clean'

  def index
  end

  def list
    areas = Area.all.inject([]) do |areas_arr, area|
      result = GeneralAppropriation.where(area_id: area.id).limit(50)
      size = result.sum(:budget_ps) +
          result.sum(:budget_mooe) +
          result.sum(:budget_co)
      count = result.count

      stim_area = area.attributes
      stim_area.merge!({
                           upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           size: size,
                           downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25),
                           count: count})

      areas_arr << {name: area.name, children: [stim_area]}
    end

    render json: {name: 'Areas', children: areas}
  end
end
