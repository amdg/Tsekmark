class SectorsController < ApplicationController
  layout 'clean'

  def index

  end

  def show
    @departments = Department.all(
        :limit => 11,
        :offset => params[:id].to_i * 11,
    )
  end

  def list
    known_sectors = {
        'D' => 'Defense',
        'DS' => 'Debt Service Payments',
        'ES' => 'Economic Services',
        'GPS' => 'General Public Services',
        'L' => 'Lending',
        'SS' => 'Social Services',
        'U' => 'Unknown'
    }
    sector_data = known_sectors.inject([]) do |hash, sector|
      (sector_code, sector_name) = sector
      result = GeneralAppropriation.joins(:owner).where('owners.sector_code' => sector_code)
      size = result.sum(:budget_ps) + result.sum(:budget_mooe) + result.sum(:budget_co)
      count = result.count

      hash << {name: sector_name, children: [
          {
              id: sector_code,
              name: sector_name,
              upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
              size: size,
              downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
              buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25)
          }

      ]}
    end

    render json: {name: 'Sectors', children: sector_data}
  end

end
