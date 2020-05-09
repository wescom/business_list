class BusinessesController < ApplicationController
    def index
      @businesses = Business.all.order('name')
    end

    def show
      @business = Business.find(params[:id])
    end

    def new
      @business = Business.new
    end

    def create
      if params[:cancel_button]
        redirect_to businesses_path
      else
        @business = Business.new(business_params)
        if @business.save
          flash_message :notice, "Business Created"
          redirect_to businesses_path
        else
          flash_message :error, "Business Creation Failed"
          render :action => :new
        end
      end    
    end
  
    def edit
      @business = Business.find(params[:id])
    end

    def update
      @business = Business.find(params[:id])
      if @business.update_attributes(business_params)
          flash_message :notice, "Business Updated"
          redirect_to businesses_path
      else
          flash_message :error, "Business Update Failed"
          render :action => :edit
      end
    end
  
    def destroy
      @business = Business.find(params[:id])
      if @business.destroy
          flash_message :notice, "Business Killed!"
          redirect_to businesses_path
      else
          flash_message :error, "Business Deletion Failed"
          redirect_to businesses_path
      end
    end

    private
      def business_params
        params.require(:business).permit(:name,:hours,:website,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes)
      end
end
