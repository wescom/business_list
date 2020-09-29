class RegionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @regions = Region.all.order('name')
  end

  def show
    @region = Region.find(params[:id])
  end

  def new
    @zone = Zone.find(params[:current_zone])
    @region = Region.new
  end

  def create
    if params[:cancel_button]
      redirect_to zones_path
    else
      @region = Region.new(region_params)
      if @region.save
        flash[:notice] = "Region Created"
        redirect_to zones_path
      else
        flash[:error] = "Region Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
    @region = Region.find(params[:id])
    if @region.update_attributes(region_params)
        flash[:notice] = "Region Updated"
        redirect_to zones_path
    else
        flash[:error] = "Region Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @region = Region.find(params[:id])
    if @region.destroy
        flash[:notice] = "Region Killed"
        redirect_to zones_path
    else
        flash[:error] = "Region Deletion Failed"
        redirect_to zones_path
    end
  end

  private
    def region_params
      params.require(:region).permit(:zone_id,:name)
    end
end
