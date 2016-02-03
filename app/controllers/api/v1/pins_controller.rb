class Api::V1::PinsController < ApplicationController

  before_action :restrict

  def index
    render json: Pin.all.order('created_at DESC')
  end

  def create
    pin = Pin.new(pin_params)
    if pin.save
      render json: pin, status: 201
    else
      render json: { errors: pin.errors }, status: 422
    end
  end



  private
    def pin_params
      params.require(:pin).permit(:title, :image_url)
    end

=begin
    def restrict
     authenticate_or_request_with_http_token do |token, options|
       #user_email=params[:email].presence
       user_email = options.blank?? nil : options[:email]
       user = user_email && User.find_by(email: user_email)
       if user && User.exists?(api_token: token)
         sign_in user
       end
     end
    end
=end

  def restrict
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_token: token).first
    end
  end

  
end
