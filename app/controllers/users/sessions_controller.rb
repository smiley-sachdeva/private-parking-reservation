class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # def create
  #   super do |resource|
  #     render json: { token: resource.generate_jwt }
  #     return
  #   end
  #   user = User.find_for_authentication(email: params[:user][:email])
  #   if user && user.valid_password?(params[:user][:password])
  #     token = user.generate_jwt
  #     render json: { token: token }
  #   else
  #     render json: { error: 'Invalid email or password' }, status: :unauthorized
  #   end
  # end

  # def respond_to_on_destroy
  #   if request.headers['Authorization'].present?
  #     jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['JWT_SECRET_KEY']).first
  #     current_user = User.find(jwt_payload['user_id'])
  #   end
    
  #   if current_user
  #     render json: {
  #       status: 200,
  #       message: 'Logged out successfully.'
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: 401,
  #       message: "Couldn't find an active session."
  #     }, status: :unauthorized
  #   end
  # end
end