class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  :jwt_authenticatable

  rolify

  # Callbacks
  after_create :assign_default_role

  def generate_jwt
    JWT.encode(jwt_payload, ENV['JWT_SECRET_KEY'])
  end

  def role_names
    roles.map(&:name)
  end
  
  private
  def assign_default_role
    self.add_role(:user) 
  end

  def jwt_payload
    {
      user_id: id,
      # jti: SecureRandom.uuid,
      exp: 1.week.from_now.to_i
    }
  end
end
