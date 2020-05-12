class BusinessTypesController < ApplicationController
    def index
      @business_types = BusinessType.all.order('name')
    end

    def show
      @business_type = BusinessType.find(params[:id])
    end

    def new
      @business_type = BusinessType.new
    end

    def create
      if params[:cancel_button]
        redirect_to business_types_path
      else
        @business_type = BusinessType.new(business_type_params)
        if @business_type.save
          flash[:notice] = "Business Type Created"
          redirect_to business_types_path
        else
          flash[:error] = "Business Type Creation Failed"
          render :action => :new
        end
      end    
    end
  
    def edit
      @business_type = BusinessType.find(params[:id])
    end

    def update
      @business_type = BusinessType.find(params[:id])
      if @business_type.update_attributes(business_type_params)
          flash[:notice] = "Business Type Updated"
          redirect_to business_types_path
      else
          flash[:error] = "Business Type Update Failed"
          render :action => :edit
      end
    end
  
    def destroy
      @business_type = BusinessType.find(params[:id])
      if @business_type.destroy
          flash[:notice] = "Business Type Killed"
          redirect_to business_types_path
      else
          flash[:error] = "Business Type Deletion Failed"
          redirect_to business_types_path
      end
    end

    private
      def business_type_params
        params.require(:business_type).permit(:name)
      end
end
