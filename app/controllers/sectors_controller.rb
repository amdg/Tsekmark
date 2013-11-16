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
    @sectors = {
        name: "Sectors",
        children: [
            {
                name: "Social Services",
                children: [
                    {id: 1, name: "Social Services", upvotes: 3123, size: 39323, downvotes: 323, buzz: 25, count: 1000}
                ]
            },
            {
                name: "General Public Service",
                children: [
                    {id: 2, name: "General Public Service", upvotes: 350, size: 3432938, downvotes: 36, buzz: 8, count: 1500}
                ]
            },
            {
                name: "Debt Burden",
                children: [
                    {id: 3, name: "Debt Burden", upvotes: 30, size: 343338, downvotes: 563, buzz: 55, count: 2000}
                ]
            },
            {
                name: "Defense",
                children: [
                    {id: 4, name: "Defense", upvotes: 150, size: 393238, downvotes: 78, buzz: 1, count: 800}
                ]
            },
            {
                name: "Economic Services",
                children: [
                    {id: 5, name: "Economic Services", upvotes: 250, size: 543938, downvotes: 383, buzz: 99, count: 1200}
                ]
            }
        ]
    }

    render json: @sectors
  end

end
