class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate

  

  def current_user 
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end


  private
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        # In production, use environment variables for safety!
        username == Blog::Env.admin_user && password == Blog::Env.admin_password
      end
    end
end
