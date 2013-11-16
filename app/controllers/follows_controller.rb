class FollowsController < ApplicationController
  def followers
    @followers = blaster.followers
  end

  def followings
    @followings = blaster.all_following
  end

  def create
    klass = params[:type].capitalize.constantize
    another_blaster = klass.find params[:id]

    if blaster.follow(another_blaster)
      flash[:notice] = "Following"
    else
      flash[:notice] = "Unable to follow"
    end
    redirect_to another_blaster
  end

  def destroy
    klass = params[:type].capitalize.constantize
    another_blaster = klass.find params[:id]

    if blaster.stop_following(another_blaster)
      flash[:notice] = "Unfollowed"
    else
      flash[:notice] = "Unable to unfollow"
    end
    redirect_to another_blaster
  end

  def follower_list
    @followers = blaster.followers.find_all { |f|
      field_name = f.is_a?(User) ? 'first_name' : 'name'
      /^#{params[:term].downcase}/ =~ f[field_name].downcase
    }

    results = @followers.inject([]) do |followers, f|
      followers << { value: f.is_a?(User) ? f.full_name : f.name, id: f.id, type: f.class.to_s }
    end
    render json: results
  end
end
