class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Ensures all actions invoke this (except those just below)
  before_action :authenticate_user!
  
  # if current_user.admin?
  #   # do something
  # end
  # 
  # if current_user.try(:admin?)
  #   # do something
  # end
end
