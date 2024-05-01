class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  rolify

  # Callbacks
  after_create :assign_default_role

  def generate_jwt
    JWT.encode({ user_id: id, exp: 1.week.from_now.to_i }, ENV['JWT_SECRET_KEY'])
  end

  def role_names
    roles.map(&:name)
  end
  
  private
  def assign_default_role
    self.add_role(:user) 
  end
end
