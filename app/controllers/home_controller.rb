class HomeController < ApplicationController

  skip_before_action :authenticate_user!
  layout 'welcome'

  def index

  end

end
