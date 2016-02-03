class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :restrict
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
  private

    def restrict
     authenticate_with_http_token do |token, options|
       #user_email=params[:email].presence
       user_email = options.blank?? nil : options[:email]
       user = user_email && User.find_by(email: user_email)
       if user && User.exists?(api_token: token)
         sign_in user
       end
     end
    end

end
