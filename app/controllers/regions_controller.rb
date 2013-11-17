class RegionsController < ApplicationController
  layout 'clean'

  def index
  end

  def list
    areas = Area.all.inject([]) do |areas_arr, area|
      size = GeneralAppropriation.where(area_id: area.id).sum(:budget_ps) +
          GeneralAppropriation.where(area_id: area.id).sum(:budget_mooe) +
          GeneralAppropriation.where(area_id: area.id).sum(:budget_co)
      count = GeneralAppropriation.where(area_id: area.id).count

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
