class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_filter :reset_database


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def reset_database
    #Track.delete_all
    #logger.info "db resetet"
  end

  helper_method :current_user
end
