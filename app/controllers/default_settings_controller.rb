class DefaultSettingsController < ApplicationController

  def index
    @default_setting = DefaultSetting.first

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
        flash_message :notice, "Settings updated"
        render :action => :index
      else
        render :action => :edit
      end
    end
  end

  private
  def default_setting_params    
    params.require(:default_setting).permit(:homepage_banner_image, :homepage_general_instruction_image, :homepage_registration_image, 
      :home_welcome_text, :general_instructions, :registration_text, :confirmation_from_email, :contact_email)
  end
end
