# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  private

  def respond_with(current_user, _opts = {})
    unless resource.persisted?
      render json: current_user.errors, status: :unprocessable_entity
    end
  end
end
