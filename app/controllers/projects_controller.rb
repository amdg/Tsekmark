class ProjectsController < ApplicationController
  layout 'clean'
  def index

  end


  def department_list
    @department = Department.find params[:id]
    @projects = @department.general_appropriations
    @descriptor = @department
    projects = @projects.inject([]) do |proj_arr, proj|
      stim_proj = proj.attributes
      stim_proj.merge!({
        name: proj.description,
        upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
        size: Forgery(:basic).number(:at_least => 200000, :at_most => 3000000),
        downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
        buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25),
        count: Forgery(:basic).number(:at_least => 5, :at_most => 25)})

      proj_arr << {name: proj.description || '---', children: [stim_proj]}
    end

    render json: {name: 'Projects', children: projects}

  end

  def region_list
    @area = Area.find params[:id]
    @projects = @area.general_appropriations
    @descriptor = @area
    projects = @projects.inject([]) do |proj_arr, proj|
      stim_proj = proj.attributes
      stim_proj.merge!({
                           name: proj.description,
                           upvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           size: Forgery(:basic).number(:at_least => 200000, :at_most => 3000000),
                           downvotes: Forgery(:basic).number(:at_least => 250, :at_most => 800),
                           buzz: Forgery(:basic).number(:at_least => 2, :at_most => 25),
                           count: Forgery(:basic).number(:at_least => 5, :at_most => 25)})

      proj_arr << {name: proj.description || '---', children: [stim_proj]}
    end

    render json: {name: 'Projects', children: projects}

  end
end
