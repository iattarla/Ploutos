class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_searching


  protected


  	def verify_is_moderator
  	  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:moderator?))
  	end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password) }
    end

  private
	def set_searching
		@q = Item.ransack(params[:q])
	end

end
