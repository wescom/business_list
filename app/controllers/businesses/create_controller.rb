class Businesses::CreateController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: [:show]

  steps :bus_info, :business_location, :business_services, :business_extras, :business_contacts

  def show
    @business = Business.find(params[:business_id])
    render_wizard
  end

  def update
    @business = Business.find(params[:business_id])
    @business.update(business_params)
    render_wizard @business
  end

  def create
    @business = Business.create
    redirect_to wizard_path(steps.first, business_id: @business.id)
  end

  private
  def business_params
    params.require(:business).permit(:name,:logo,:business_type_id,{:business_subtype_ids=>[]},{:service_type_ids=>[]},{:zone_ids=>[]},:hours,
    :website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes,:yelp_url,:business_listing_zone,:happy_hour,:award_id,:owner_id,
    :status, :approved )
  end

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    else
      @progress = 0
    end
  end
end
