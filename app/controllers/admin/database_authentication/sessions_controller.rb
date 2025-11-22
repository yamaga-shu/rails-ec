# frozen_string_literal: true

class Admin::DatabaseAuthentication::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /admin/login
  def new
    super
  end

  # POST /admin/login
  def create
    super
  end

  # DELETE /admin/logout
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
