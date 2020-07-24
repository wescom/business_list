class ApplicationController < ActionController::Base
  include ApplicationHelper

  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  before_action :set_mailer_host

  before_action :load_default_settings

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || businesses_path
  end

  def load_default_settings
    @default_settings = DefaultSetting.first
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
    

end
