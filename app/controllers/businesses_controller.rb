class BusinessesController < ApplicationController
  load_and_authorize_resource

  skip_before_action :authenticate_user!, :only => [:business_listing,:restaurant_listing]
  layout 'listings', :only => [:business_listing, :restaurant_listing]
  helper_method :sort_column, :sort_direction

  def index
    if can? :manage, Business
      @businesses = Business.left_outer_joins(:business_type)
    else
      @businesses = Business.where(:owner_id => current_user).left_outer_joins(:business_type)
    end
    @businesses = @businesses.where.not(name: [nil, ""])
    if !params[:type].nil?
      @businesses = @businesses.where('business_types.name = ?', params[:type])
    end
    @businesses = @businesses.order(sort_column + " " + sort_direction)
  end
  
  def business_listing
    # lists businesses for embedding into an external webpage using paramter 'type'
    @businesses = Business.left_outer_joins(:business_type)              #.left_outer_joins(:businesses_service_types).joins(:service_types)
    if !params[:type].nil?
      @businesses = @businesses.where('business_types.name = ?', params[:type])
    end
    @businesses = @businesses.order(sort_column + " " + sort_direction)
  end
  
  def show
    @business = Business.find(params[:id])
    @business_subtypes = @business.business_subtypes
  end

  def new
    @business_types = BusinessType.all.order("name")
    @business_subtypes = BusinessType.first.business_subtypes
    @service_types = ServiceType.all.order("name")
    @zones = Zone.all.order("name")
    @users = User.all.order("email")

    @business = Business.new
    @business.owner_id = current_user.id
  end

  def create_business_wizard
    # Find businesses of current user that are not active
    @businesses = Business.where(:owner_id => current_user.id)
    @businesses = @businesses.where.not(status: "active").where.not(status: "approved")
    if @businesses.empty?
      @business = Business.new({owner_id: current_user.id})
      @business.status = 'business_info'
      @business.save
      puts "*** create new ****"+@business.inspect
      redirect_to business_create_path(business_id: @business.id, id: :business_info)
    else
      @business = @businesses.first
      puts "*** found existing ****"+@business.inspect
      redirect_to business_create_path(business_id: @business.id, id: @business.status)
    end
  end

  def create
    if params[:cancel_button]
      redirect_to businesses_path
    else
      @business_types = BusinessType.all.order("name")
      @service_types = ServiceType.all.order("name")
      @zones = Zone.all.order("name")

      @business = Business.new(business_params)
      @business.owner_id = current_user.id
      @business.status = "approved"
      if @business.save
        flash[:notice] = "Business Created"
        redirect_to @business
      else
        flash[:notice] = "Business Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @business_types = BusinessType.all.order("name")
    if @business.business_type.nil?
      @business_subtypes = BusinessType.first.business_subtypes
    else
      @business_subtypes = @business.business_type.business_subtypes
    end
    @service_types = ServiceType.all.order("name")
    @zones = Zone.all.order("name")
    @users = User.all.order("email")

    @business = Business.find(params[:id])
  end

  def update
    @business_types = BusinessType.all.order("name")
    if @business.business_type.nil?
      @business_subtypes = BusinessType.first.business_subtypes
    else
      @business_subtypes = @business.business_type.business_subtypes
    end
    @service_types = ServiceType.all.order("name")
    @zones = Zone.all.order("name")

    @business = Business.find(params[:id])
    if @business.update(business_params)
        flash[:notice] = "Business Updated"
        redirect_to @business
    else
        flash[:notice] = "Business Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @business = Business.find(params[:id])
    if @business.destroy
        flash[:notice] = "Business Deleted"
        redirect_to businesses_path
    else
        flash[:notice] = "Business Deletion Failed"
        redirect_to businesses_path
    end
  end
  
  def approve_business
    @business = Business.find(params[:business_id])
    if @business.present?
      @business.approved = true
      @business.status = "approved"
      if @business.save
        flash[:notice] = "Business Approved"
        redirect_to @business
      else
        flash[:notice] = "Business Approval Failed"
        redirect_to @business
      end
    end
  end

  private
    def business_params
      params.require(:business).permit(:name,:logo,:business_type_id,{:business_subtype_ids=>[]},{:service_type_ids=>[]},{:zone_ids=>[]},:hours,
      :website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes,:yelp_url,:business_listing_zone,:happy_hour,:award_id,:owner_id,
      :status, :approved )
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
