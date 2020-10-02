class Businesses::CreateController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: [:show]

  steps :business_info, :business_location, :business_services, :business_extras, :business_contacts

  def show
    @business_types = BusinessType.all.order("name")
    @business_subtypes = BusinessType.first.business_subtypes
    @service_types = ServiceType.all.order("name")
    @zones = Zone.all.order("name")
    @business_regions = Zone.all.order("name")
    @users = User.all.order("email")

    @business = Business.find(params[:business_id])
    render_wizard
  end

  def update
    @business_types = BusinessType.all.order("name")
    @business_subtypes = BusinessType.first.business_subtypes
    @service_types = ServiceType.all.order("name")
    @zones = Zone.all.order("name")
    @business_regions = Zone.all.order("name")
    @users = User.all.order("email")

    @business = Business.find(params[:business_id])
    @business.website = sanitize_website(@business.website) unless @business.website.nil?
    @business.status = (step == steps.last ? 'active' : step.to_s)
    if step.to_s == "business_services"
      if params[:business][:region_id].nil? # if no region was selected, clear the current business region_id
        @business.region_id = nil
      end
    end
    @business.update(business_params)
    render_wizard @business
  end
  
  def create
    @business = Business.create
    @business.save
    redirect_to wizard_path(steps.first, business_id: @business.id)
  end

  private
  def business_params
    params.require(:business).permit(:name,:logo,:business_type_id,{:business_subtype_ids=>[]},{:service_type_ids=>[]},:zone_ids,:region_id,:hours,
    :website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes,:yelp_url,:business_listing_zone,:happy_hour,:award_id,:owner_id,
    :status, :approved )
  end
  
  def finish_wizard_path
    businesses_path
  end

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    else
      @progress = 0
    end
  end

  def sanitize_website(url)
    unless url.include?("http://") || url.include?("https://")
      url = "http://" + url
    end
    return url
  end
end
