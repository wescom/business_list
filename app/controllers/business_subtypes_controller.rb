class BusinessSubtypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @business_subtypes = BusinessSubtype.all.order('name')
  end

  def show
    @business_subtype = BusinessSubtype.find(params[:id])
  end

  def new
    @business_subtype = BusinessSubtype.new
  end

  def create
    if params[:cancel_button]
      redirect_to business_types_path
    else
      @business_subtype = BusinessSubtype.new(business_subtype_params)
      if @business_subtype.save
        flash[:notice] = "Business Subtype Created"
        redirect_to business_types_path
      else
        flash[:error] = "Business Subtype Creation Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @business_subtype = BusinessSubtype.find(params[:id])
  end

  def update
    @business_subtype = BusinessSubtype.find(params[:id])
    if @business_subtype.update_attributes(business_subtype_params)
        flash[:notice] = "Business Subtype Updated"
        redirect_to business_types_path
    else
        flash[:error] = "Business Subtype Update Failed"
        render :action => :edit
    end
  end

  def destroy
    @business_subtype = BusinessSubtype.find(params[:id])
    if @business_subtype.destroy
        flash[:notice] = "Business Subtype Killed"
        redirect_to business_types_path
    else
        flash[:error] = "Business Subtype Deletion Failed"
        redirect_to business_types_path
    end
  end

  private
    def business_subtype_params
      params.require(:business_subtype).permit(:business_type_id,:name)
    end
end
