class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]

  def create
    admin = Client.find_by!(email: params[:email])

    if admin.authenticate(params[:password])
      render json: {
        login: true,
        user: admin
       }
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: 'Cannont find such email/password combination' }, status: :not_found
  end
end
