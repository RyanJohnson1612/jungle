class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV['SUPER_SECURE_USERNAME'], :password => ENV['SUPER_SECURE_PASSWORD']

  def show
  end
end
