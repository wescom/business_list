class BusinessesController < ApplicationController
  load_and_authorize_resource :except => [:maps, :business_listing, :business_listing_map]

  skip_before_action :authenticate_user!, :only => [:maps, :business_listing, :business_listing_map]
  layout :determine_layout
  helper_method :sort_column, :sort_direction

  def index
    if can? :manage, Business
      @businesses = Business.left_outer_joins(:business_type)
      @businesses = @businesses.where('businesses.name LIKE ?', "%#{params[:search_query]}%") if params[:search_query].present?
      @businesses = @businesses.where(status: params[:status_select]) if params[:status_select].present?
    else
      @businesses = Business.where(:owner_id => current_user).left_outer_joins(:business_type)
    end
    @businesses = @businesses.where.not(name: [nil, ""])
    if !params[:type].nil?
      @businesses = @businesses.where('business_types.name = ?', params[:type])
    end
    if current_user.admin_role? and !params[:owner].nil?
      @businesses = @businesses.where('businesses.owner_id = ?', params[:owner])
    end
    @businesses = @businesses.order(sort_column + " " + sort_direction).distinct
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
    @business_regions = Zone.first.regions
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
      @business.status = 'new'
      @business.save!
      puts "*** create new ****"+@business.inspect
      redirect_to business_create_path(business_id: @business.id, id: :business_info)
    else
      @business = @businesses.first
      @business.status = 'business_info' if @business.status == 'new'
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
    if @business.zones.nil?
      @business_regions = Zone.first.regions
    else
      @business_regions = Region.where(:zone_id => @business.zones ).order(:name)
    end
    @users = User.all.order("email")

    @business = Business.find(params[:id])
  end

  def update
    if params[:cancel_button]
      redirect_to @business
    else
      @business_types = BusinessType.all.order("name")
      if @business.business_type.nil?
        @business_subtypes = BusinessType.first.business_subtypes
      else
        @business_subtypes = @business.business_type.business_subtypes
      end
      @service_types = ServiceType.all.order("name")
      @zones = Zone.all.order("name")
      if @business.zones.nil?
        @business_regions = Zone.first.regions
      else
        @business_regions = Region.where(:zone_id => @business.zones ).order(:name)
      end

      @business = Business.find(params[:id])
      if !current_user.admin_role?    # current user is not an Admin so require the business to be Approved
        @business.status = "active"
        @business.approved = false
      end
      if params[:business][:region_id].nil? # if no region was selected, clear the current business region_id
        @business.region_id = nil
      end
      if @business.update(business_params)
          flash[:notice] = "Business Updated"
          if current_user = @business.owner   # If owner makes a change, email changes
            @default_settings_email = DefaultSettingsEmail.find_by(name: 'Business Updated')
            BusinessMailer.business_updated(@business,@default_settings_email).deliver_later unless @default_settings_email.nil? 
          end
          @default_settings_email = DefaultSettingsEmail.find_by(name: 'Business Waiting For Approval')
          BusinessMailer.business_waiting_for_approval(@business,@default_settings_email).deliver_later unless @default_settings_email.nil? 
          redirect_to @business
      else
          flash[:notice] = "Business Update Failed"
          render :action => :edit
      end
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

  def pause_business
    @business = Business.find(params[:business_id])
    if @business.present?
      if @business.pause_listing
        @business.pause_listing = false
        if @business.save
          flash[:notice] = "Business Unpaused"
          redirect_to @business
        else
          flash[:notice] = "Unpause Failed"
          redirect_to @business
        end
      else
        @business.pause_listing = true
        if @business.save
          flash[:notice] = "Business Paused"
          redirect_to @business
        else
          flash[:notice] = "Pause Failed"
          redirect_to @business
        end
      end
    end
  end
  
  def business_listing_map
    @business_types = BusinessType.order("name")
    @business_type_label = BusinessType.where('business_types.name = ?', params[:type]).first
    if params[:type].nil?
      # switch to filtering by type when no type param
      # @business_subtypes = BusinessSubtype.all.joins(:business_type).order("business_types.name","business_subtypes.name")
    else
      @business_subtypes = BusinessSubtype.joins(:business_type).where('business_types.name = ?', params[:type]).order("name") unless params[:type].nil?
    end
    @service_types = ServiceType.all.order("name")

    # lists businesses for embedding into an external webpage using paramters 'type', 'service_type', 'zone'
    @businesses = Business.all
    @businesses = @businesses.left_outer_joins(:business_type).where('business_types.name = ?', params[:type]) unless params[:type].nil? || params[:type].empty?
    @businesses = @businesses.left_outer_joins(:business_subtypes).where('business_subtypes.name = ?', params[:business_subtype]) unless params[:business_subtype].nil? || params[:business_subtype].empty?
    @businesses = @businesses.left_outer_joins(:zones).where('zones.name = ?', params[:zone]) unless params[:zone].nil? || params[:zone].empty?
    @businesses = @businesses.left_outer_joins(:service_types).where('service_types.name = ?', params[:service_type]) unless params[:service_type].nil? || params[:service_type].empty?
    @businesses = @businesses.where(happy_hour: true) unless params[:happy_hour] != 'true'
    @businesses = @businesses.where(food_truck: true) unless params[:food_truck] != 'true'
    @businesses = @businesses.where(approved: true).where('pause_listing is null or pause_listing != true').distinct
    @businesses = @businesses.order('city').order('name')

    @business_locations = get_business_locations(@businesses).reject(&:blank?)
    params[:zoom] = (params[:zoom] && params[:zoom].to_i > 0) ? params[:zoom] : 11
    params[:center] = get_center_geocode(params[:center],params[:zone])
  end

  def business_listing
    @business_types = BusinessType.order("name")
    @business_type_label = BusinessType.where('business_types.name = ?', params[:type]).first
    if params[:type].nil?
      # switch to filtering by type when no type param
      # @business_subtypes = BusinessSubtype.all.joins(:business_type).order("business_types.name","business_subtypes.name")
    else
      @business_subtypes = BusinessSubtype.joins(:business_type).where('business_types.name = ?', params[:type]).order("name") unless params[:type].nil?
    end
    @service_types = ServiceType.all.order("name")

    # lists businesses for embedding into an external webpage using paramters 'type', 'service_type', 'zone'
    @businesses = Business.all
    @businesses = @businesses.left_outer_joins(:business_type).where('business_types.name = ?', params[:type]) unless params[:type].nil? || params[:type].empty?
    @businesses = @businesses.left_outer_joins(:business_subtypes).where('business_subtypes.name = ?', params[:business_subtype]) unless params[:business_subtype].nil? || params[:business_subtype].empty?
    @businesses = @businesses.left_outer_joins(:zones).where('zones.name = ?', params[:zone]) unless params[:zone].nil? || params[:zone].empty?
    @businesses = @businesses.left_outer_joins(:service_types).where('service_types.name = ?', params[:service_type]) unless params[:service_type].nil? || params[:service_type].empty?
    @businesses = @businesses.where(happy_hour: true) unless params[:happy_hour] != 'true'
    @businesses = @businesses.where(food_truck: true) unless params[:food_truck] != 'true'
    @businesses = @businesses.where(approved: true).where('pause_listing is null or pause_listing != true').distinct
    @businesses = @businesses.order('city').order('name')

    @business_locations = get_business_locations(@businesses).reject(&:blank?)
    params[:zoom] = (params[:zoom] && params[:zoom].to_i > 0) ? params[:zoom] : 11
    params[:center] = get_center_geocode(params[:center],params[:zone])
  end
  
  def maps
    # maps businesses for embedding into an external webpage using paramter 'type'
    @businesses = Business.all
    @businesses = @businesses.left_outer_joins(:business_type).where('business_types.name = ?', params[:type]) unless params[:type].nil? || params[:type].empty?
    @businesses = @businesses.left_outer_joins(:business_subtypes).where('business_subtypes.name = ?', params[:business_subtype]) unless params[:business_subtype].nil? || params[:business_subtype].empty?
    @businesses = @businesses.left_outer_joins(:zones).where('zones.name = ?', params[:zone]) unless params[:zone].nil? || params[:zone].empty?
    @businesses = @businesses.left_outer_joins(:service_types).where('service_types.name = ?', params[:service_type]) unless params[:service_type].nil? || params[:service_type].empty?
    @businesses = @businesses.where(happy_hour: true) unless params[:happy_hour] != 'true'
    @businesses = @businesses.where(food_truck: true) unless params[:food_truck] != 'true'
    @businesses = @businesses.where(approved: true).where('pause_listing is null or pause_listing != true').distinct
    @businesses = @businesses.order('name')

    @business_locations = get_business_locations(@businesses).reject(&:blank?)
    params[:zoom] = (params[:zoom] && params[:zoom].to_i > 0) ? params[:zoom] : 11
    params[:center] = get_center_geocode(params[:center],params[:zone])
  end

  def get_map_markers
    @businesses = Business.all
    @businesses = @businesses.left_outer_joins(:business_type).where('business_types.name = ?', params[:type]) unless params[:type].nil? || params[:type].empty?
    @businesses = @businesses.left_outer_joins(:business_subtypes).where('business_subtypes.name = ?', params[:business_subtype]) unless params[:business_subtype].nil? || params[:business_subtype].empty?
    @businesses = @businesses.left_outer_joins(:zones).where('zones.name = ?', params[:zone]) unless params[:zone].nil? || params[:zone].empty?
    @businesses = @businesses.left_outer_joins(:service_types).where('service_types.name = ?', params[:service_type]) unless params[:service_type].nil? || params[:service_type].empty?
    @businesses = @businesses.where(happy_hour: true) unless params[:happy_hour] != 'true'
    @businesses = @businesses.where(food_truck: true) unless params[:food_truck] != 'true'
    @businesses = @businesses.where(approved: true).where('pause_listing is null or pause_listing != true').distinct

    @map_markers = Gmaps4rails.build_markers(@businesses) do |business, marker|
      if business.lat.nil? or business.lng.nil?
        puts "Geocoder coordinates nil: " + helpers.business_address_city_state_zip(business)
      else
        marker.lat business.lat
        marker.lng business.lng
        marker.picture({
#          "url" => "http://maps.google.com/mapfiles/ms/icons/green.png",
          "width" =>  32,
          "height" => 32})
          marker.title business.name
          marker.json({ :id => business.id })
        marker.infowindow render_to_string(:partial => "/businesses/maps_infowindow", :locals => {:business => business})
      end
    end
    return @map_markers
  end
  
  private
    def business_params
      params.require(:business).permit(:name,:logo,:business_type_id,{:business_subtype_ids=>[]},{:service_type_ids=>[]},:zone_ids,:region_id,:hours,
      :website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes,:yelp_url,:business_listing_zone,:happy_hour,:food_truck,:award_id,:owner_id,
      :status, :approved )
    end

    def determine_layout
      case action_name
      when "business_listing"
        "maps"
      when "business_listing_map"
        "maps"
      when "maps"
        "maps"
      else
        "application"
      end
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

    def get_business_locations(businesses)  
      @business_locations = businesses
      @business_locations = Gmaps4rails.build_markers(@business_locations) do |business, marker|
        if business.lat.nil? or business.lng.nil?
          puts "Geocoder coordinates nil: " + helpers.business_address_city_state_zip(business)
        else
          marker.lat business.lat
          marker.lng business.lng
          marker.picture({
  #          "url" => "http://maps.google.com/mapfiles/ms/icons/green.png",
            "width" =>  32,
            "height" => 32})
            marker.title business.name
            marker.json({ :id => business.id })
          marker.infowindow render_to_string(:partial => "/businesses/maps_infowindow", :locals => {:business => business})
        end
      end  
      return @business_locations
    end

    def get_center_geocode(center,zone)
      coord_string = []
      if center.nil? || center.empty?
        # center is not defined
        zone = zone.nil? || zone.empty? ? "Bend" : zone 
        coords = Geocoder.coordinates(zone+", OR")
        if !coords.nil?
          coord_string[0] = coords[0]
          coord_string[1] = coords[1]
        end
        #puts "****** "+coord_string.inspect
      else
        # center is defined
        coord_string = center
        #puts "****** "+coord_string.inspect
      end
      return coord_string
    end
end
