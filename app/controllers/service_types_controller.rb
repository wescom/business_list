class ServiceTypesController < ApplicationController
    def index
      @service_types = ServiceType.all.order('name')
    end

    def show
      @service_type = ServiceType.find(params[:id])
    end

    def new
      @service_type = ServiceType.new
    end

    def create
      if params[:cancel_button]
        redirect_to service_types_path
      else
        @service_type = ServiceType.new(service_type_params)
        if @service_type.save
          flash_message :notice, "Business Type Created"
          redirect_to service_types_path
        else
          flash_message :error, "Business Type Creation Failed"
          render :action => :new
        end
      end    
    end
  
    def edit
      @service_type = ServiceType.find(params[:id])
    end

    def update
      @service_type = ServiceType.find(params[:id])
      if @service_type.update_attributes(service_type_params)
          flash_message :notice, "Business Type Updated"
          redirect_to service_types_path
      else
          flash_message :error, "Business Type Update Failed"
          render :action => :edit
      end
    end
  
    def destroy
      @service_type = ServiceType.find(params[:id])
      if @service_type.destroy
          flash_message :notice, "Business Type Killed!"
          redirect_to service_types_path
      else
          flash_message :error, "Business Type Deletion Failed"
          redirect_to service_types_path
      end
    end

    private
      def service_type_params
        params.require(:service_type).permit(:name)
      end
end
