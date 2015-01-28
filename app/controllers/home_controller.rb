class HomeController < ApplicationController
  def index
    redirect_to dashboards_path if current_user.present?
  end
end
