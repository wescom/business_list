class AwardsController < ApplicationController
  load_and_authorize_resource

  def index
    @awards = Award.all.order('name')
  end

  def show
    @award = Award.find(params[:id])
  end

  def new
    @award = Award.new
  end

  def create
    if params[:cancel_button]
      redirect_to awards_path
    else
      @award = Award.new(award_params)
      if @award.save
        flash[:notice] = "Award Created"
        redirect_to awards_path
      else
        flash[:error] = "Award Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @award = Award.find(params[:id])
  end

  def update
    @award = Award.find(params[:id])
    if @award.update_attributes(award_params)
        flash[:notice] = "Award Updated"
        redirect_to awards_path
    else
        flash[:error] = "Award Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @award = Award.find(params[:id])
    if @award.destroy
        flash[:notice] = "Award Killed"
        redirect_to awards_path
    else
        flash[:error] = "Award Deletion Failed"
        redirect_to awards_path
    end
  end

  private
    def award_params
      params.require(:award).permit(:name,:description,:year,:place)
    end
end
