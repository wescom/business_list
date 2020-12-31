class DefaultSettingsEmailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @default_settings_emails = DefaultSettingsEmail.all.order("name")

    if @default_settings_emails.empty?
      # If no email records, then create one and send user to edit
      DefaultSettingsEmail.create(name: 'Welcome')
      flash_message :notice, "Default emails have not been set. Please create one."
      redirect_to default_settings_path
    end
  end

  def new
    # list of programmed email templates available
    @email_templates_options = DefaultSettingsEmail::EMAIL_TEMPLATES
    # current list of templates with default settings
    @current_email_templates = DefaultSettingsEmail.where(name: @email_templates_options).pluck('name')
    # list of templates available for creating and setting defaults
    @email_templates = @email_templates_options - @current_email_templates

    if @email_templates.nil? || @email_templates.empty?
      flash[:error] = "All available email templates have been created"
      redirect_to default_settings_path
    end

    @default_settings_email = DefaultSettingsEmail.new
  end

  def create
    if params[:cancel_button]
      redirect_to default_settings_path
    else
      @default_settings_email = DefaultSettingsEmail.new(default_settings_emails_params)
      if @default_settings_email.save
        flash[:notice] = "Email Template Created"
        redirect_to default_settings_path
      else
        flash[:error] = "Email Template Failed"
        render :action => :new
      end
    end    
  end

  def edit
    @default_settings_email = DefaultSettingsEmail.find(params[:id])
  end

  def update
    @default_settings_email = DefaultSettingsEmail.find(params[:id])
    if params[:cancel_button]
      redirect_to default_settings_path
    else
      if @default_settings_email.update_attributes(default_settings_emails_params)
        flash[:notice] = "Email Template Updated"
        redirect_to default_settings_path
      else
        flash[:error] = "Email Template Update Failed"
        render :action => :edit
      end
    end
  end

  def destroy
    @default_settings_email = DefaultSettingsEmail.find(params[:id])
    if @default_settings_email.destroy
        flash[:notice] = "Email Template Deleted"
        redirect_to default_settings_path
    else
        flash[:notice] = "Email Template Deletion Failed"
        redirect_to default_settings_path
    end
  end
  
  private
  def default_settings_emails_params    
    params.require(:default_settings_email).permit(:name,:description,:email_from_address,:email_subject,:email_pretext,
    :email_posttext,:show_contact_info,:show_business_info)
  end
end
