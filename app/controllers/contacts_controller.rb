class ContactsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  def new
    session[:return_to] = request.referer
    
    @business = Business.find(params[:current_business])
    @contact = Contact.new
  end

  def create
    @business = Business.find(params[:contact][:business_id])
    if params[:cancel_button]
      redirect_to session[:return_to]
    else
      @contact = Contact.new(contact_params)
      if @contact.save
        flash[:notice] = "New Contact Added"
        redirect_to session[:return_to]
      else
        flash[:notice] = "Contact Failed"
        render :action => :new
      end
    end
  end

  def edit
    session[:return_to] = request.referer
    
    @business = Business.find(params[:current_business])
    @contact = Contact.find(params[:id])
  end

  def update
    @business = Business.find(params[:contact][:business_id])
    @contacts = Contact.find(params[:id])
    if params[:cancel_button]
      redirect_to session[:return_to]
    else
      if @contacts.update_attributes(contact_params)
        flash[:notice] = "Contact Updated"
        redirect_to session[:return_to]
      else
        flash[:notice] = "Contact Failed"
        render :action => :edit
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    
    @contact = Contact.find(params[:id])
    if @contact.destroy
      flash[:notice] = "Contact Removed"
      redirect_to session[:return_to]
    else
      flash[:notice] = "Contact Removal Failed"
      redirect_to session[:return_to]
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:business_id,:name,:address1,:address2,:city,:state,:zipcode,:phonenum,:email,:notes)
    end
  
end
