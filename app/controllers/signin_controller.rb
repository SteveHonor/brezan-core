class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]

  def create
    admin = Admin.find_by!(email: params[:email])

    if admin.authenticate(params[:password])

      payload = { admin_id: admin.id }

      session = JWTSessions::Session.new(
        payload: payload,
        refresh_by_access_allowed: true
      )

      tokens = session.login

      response.set_cookie(
        JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?
      )

      render json: {
        login: true,
        csrf: tokens[:csrf],
        user: {
          id: admin.id,
          name: admin.name,
          email: admin.email
        }
      }
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: { admin_id: admin.id })
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: 'Cannont find such email/password combination' }, status: :not_found
  end
end
