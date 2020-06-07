class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_mailer_host

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
    

end
