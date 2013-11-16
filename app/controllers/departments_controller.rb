class DepartmentsController < ApplicationController
  layout 'clean'
  def index

  end

  def sector_list
    @departments = Department.all(
        :limit => 11,
        :offset => (params[:id].to_i - 1) * 11,
    )

    depts = @departments.inject([]) do |depts_arr, dept|
      stim_dept = dept.attributes
      stim_dept.merge!({
         upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
         size: Forgery(:basic).number(:at_least => 200000, :at_most => 3000000),
         downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
         buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25),
         count: Forgery(:basic).number(:at_least => 5, :at_most => 25)})

      depts_arr << {name: dept.name, children: [stim_dept]}
    end

    render json: {name: 'Departments', children: depts}

  end
end
