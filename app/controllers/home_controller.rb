class HomeController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index]
  layout 'advertiser', :only => [:index]

  def index

  end

  def welcome

  end

end
