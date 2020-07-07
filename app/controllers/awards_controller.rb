class AwardsController < ApplicationController
  load_and_authorize_resource

  def new
    @business = Business.find(params[:current_business])
    @award = Award.new
  end

  def create
    @business = Business.find(params[:award][:business_id])
    if params[:cancel_button]
      redirect_to @business
    else
      @award = Award.new(award_params)
      if @award.save
        flash[:notice] = "Award Created"
        redirect_to @business
      else
        flash[:error] = "Award Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @business = Business.find(params[:current_business])
    @award = Award.find(params[:id])
  end

  def update
    @business = Business.find(params[:award][:business_id])
    @award = Award.find(params[:id])
    if @award.update_attributes(award_params)
        flash[:notice] = "Award Updated"
        redirect_to @business
    else
        flash[:error] = "Award Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @award = Award.find(params[:id])
    if @award.destroy
        flash[:notice] = "Award Killed"
        redirect_to @award.business
    else
        flash[:error] = "Award Deletion Failed"
        redirect_to @award.business
    end
  end

  private
    def award_params
      params.require(:award).permit(:business_id,:name,:description,:year,:place)
    end
end
