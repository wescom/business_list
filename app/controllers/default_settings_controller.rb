class DefaultSettingsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @default_setting = DefaultSetting.first
    @default_settings_emails = DefaultSettingsEmail.all.order("name")

    if @default_setting.nil?
      # If no default settings record, then create one and send user to edit
      DefaultSetting.create(home_welcome_text: 'This is your welcome message')
      flash_message :notice, "Default settings have not been set. Please update defaults."
      redirect_to default_settings_path
    end
  end

  def edit
    @default_setting = DefaultSetting.find(params[:id])
  end

  def update
    @default_setting = DefaultSetting.find(params[:id])
    if params[:cancel_button]
      redirect_to default_settings_path
    else
      if @default_setting.update_attributes(default_setting_params)
        flash[:notice] = "Settings updated"
        render :action => :index
      else
        flash[:error] = "Error"
        render :action => :edit
      end
    end
  end

  private
  def default_setting_params    
    params.require(:default_setting).permit(:homepage_banner_image, :homepage_general_instruction_image, :homepage_registration_image, 
      :home_welcome_text, :general_instructions, :registration_text, :registered_welcome_text, :registered_welcome_image,
      :confirmation_from_email, :contact_email)
  end
end
