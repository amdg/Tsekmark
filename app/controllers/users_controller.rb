class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user, only: [:update, :show, :destroy, :resume]

  def index
    #authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @profile = @user
    render :layout => 'layouts/profile'
  end
  
  def update
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    unless @user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end