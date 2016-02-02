class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :generate_token

=begin
  before_save :ensure_authentication_token

  def ensure_authentication_token
    if api_token.blank?
      generate_token
    end
  end
=end

  private
    def generate_token
      self.api_token ||= SecureRandom.hex if new_record?
    end
end
