class ZonesController < ApplicationController
  load_and_authorize_resource

  def index
    @zones = Zone.all.order('name')
  end

  def show
    @zone = Zone.find(params[:id])
  end

  def new
    @zone = Zone.new
  end

  def create
    if params[:cancel_button]
      redirect_to zones_path
    else
      @zone = Zone.new(zone_params)
      if @zone.save
        flash[:notice] = "Zone Created"
        redirect_to zones_path
      else
        flash[:error] = "Zone Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @zone = Zone.find(params[:id])
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone.update_attributes(zone_params)
        flash[:notice] = "Zone Updated"
        redirect_to zones_path
    else
        flash[:error] = "Zone Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @zone = Zone.find(params[:id])
    puts @zone.inspect
    if @zone.destroy
        flash[:notice] = "Zone Killed"
        redirect_to zones_path
    else
        flash[:error] = "Zone Deletion Failed"
        redirect_to zones_path
    end
  end

  def zone_region_options
    business_regions = Region.where(:zone_id => params[:zone_id]) unless params[:zone_id].nil?

    respond_to do |format|
      format.html
      format.json  { render :json => {:business_regions => business_regions} }
    end
  end
  private
    def zone_params
      params.require(:zone).permit(:name)
    end
end
