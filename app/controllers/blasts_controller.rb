class BlastsController < ApplicationController
  before_filter :load_blast_from_id, only: [:comment, :comments]

  def create
    blast_params = params[:blast]

    @blast = Blaster.new(blaster.blasts.build(body: blast_params[:body]), blast_params[:location])
    if @blast.save
      flash[:notice] = "Blast posted"
    else
      flash[:notice] = "Unable to post blast."
    end
    redirect_to dashboard_index_path
  end

  def destroy
    @blast = current_user.blasts.find(params[:id])
    @blast.destroy
    flash[:notice] = "Blast removed"
    redirect_to dashboard_index_path
  end

  def comment
    @blast.comments.create(:comment => params[:comment][:comment], blaster: blaster)
    redirect_to @blast.blaster
  end

  def load_blast_from_id
    @blast = Blast.find params[:blast_id]
  end

  def show
    @blast = Blast.find params[:id]
  end
end
