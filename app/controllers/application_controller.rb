class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_with_token!

  def current_user
     @current_user ||= User.find_by(api_token: request.headers['Authorization'])
   end

   def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless current_user.present?
  end
#  before_action :authenticate_user!
=begin
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  private
  def authenticate_user_from_token!
    user_email=params[:user_email].presence
    user = user_email && User.find_by_email(user_email)
    if user && Devise.secure_compare(user.api_token, params[:user_token])
      sign_in user
    end
  end
=end
end
