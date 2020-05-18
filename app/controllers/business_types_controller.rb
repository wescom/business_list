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
    
    def get_subtypes_for_business_type(business_type_id)
      puts business_type_id.to_s
      @business_subtypes = BusinessType.find(business_type_id).business_subtypes unless business_type_id.nil?
      puts @business_subtypes.inspect
    end
    
    def business_subtype_options
      business_subtypes = BusinessSubtype.where(:business_type_id => params[:business_type_id]) unless params[:business_type_id].nil?
puts "Return business_subtypes to form: "+business_subtypes.inspect

      respond_to do |format|
        format.html
        format.json  { render :json => {:business_subtypes => business_subtypes} }
      end
    end

    private
      def business_type_params
        params.require(:business_type).permit(:name,:title_for_subtypes)
      end
end
