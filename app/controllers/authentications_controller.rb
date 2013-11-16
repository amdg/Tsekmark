class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    blaster.authentications.destroy params[:id]
    redirect_to edit_blaster_path
  end

end
