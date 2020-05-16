class BusinessesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index,:business_listing,:restaurant_listing]
  layout 'listings', :only => [:business_listing, :restaurant_listing]
  helper_method :sort_column, :sort_direction

  def index
      @businesses = Business.joins(:business_type).joins(:service_type).order(sort_column + " " + sort_direction)
  end
  
  def business_listing
    # lists retail businesses for embedding into an external webpage
    @businesses = Business.joins(:business_type).where('business_types.name = ?', "Restaurant").order('name')
  end
  
  def restaurant_listing
    # lists restaurants for embedding into an external webpage
    @businesses = Business.joins(:business_type).where('business_types.name = ?', "Retail").order('name')
  end
  
  def show
      @business = Business.find(params[:id])
      @business_subtypes = @business.business_subtypes
  end

  def new
    @business = Business.new
    @business_types = BusinessType.all.order("name")
#    @business_subtypes = @business.business_type.business_subtypes
    @service_types = ServiceType.all.order("name")
  end

  def create
    if params[:cancel_button]
      redirect_to businesses_path
    else
      @business_types = BusinessType.all.order("name")
      @business_subtypes = @business.business_type.business_subtypes
      @service_types = ServiceType.all.order("name")
      @business = Business.new(business_params)
      if @business.save
        flash[:notice] = "Business Created"
        redirect_to businesses_path
      else
        flash[:notice] = "Business Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @business = Business.find(params[:id])
    @business_types = BusinessType.all.order("name")
    @business_subtypes = @business.business_type.business_subtypes
    @service_types = ServiceType.all.order("name")
  end

  def update
    @business = Business.find(params[:id])
    @business_types = BusinessType.all.order("name")
    @business_subtypes = @business.business_type.business_subtypes
    @service_types = ServiceType.all.order("name")
    if @business.update_attributes(business_params)
        flash[:notice] = "Business Updated"
        redirect_to businesses_path
    else
        flash[:notice] = "Business Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @business = Business.find(params[:id])
    if @business.destroy
        flash[:notice] = "Business Killed"
        redirect_to businesses_path
    else
        flash[:notice] = "Business Deletion Failed"
        redirect_to businesses_path
    end
  end

  private
    def business_params
      params.require(:business).permit(:name,:logo,:business_type_id,{:business_subtype_ids=>[]},:service_type_id,:hours,:website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes)
    end
    
    def column_exists?(column)
      if Business.column_names.include?(column) 
        return true
      else
        case
        when column.nil?
          return false
        when column.include?('business_types')
          return true
        when column.include?('service_types')
          return true
        else
          return false
        end
      end
    end
    
    def sort_column
      column_exists?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
