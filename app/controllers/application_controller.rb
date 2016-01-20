class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def verify_is_moderator
	  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:moderator?))
  end


end
