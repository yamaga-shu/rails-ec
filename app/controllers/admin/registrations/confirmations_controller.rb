# frozen_string_literal: true

class Admin::Registrations::ConfirmationsController < Devise::ConfirmationsController
  # GET /admin/confirmation/new
  def new
    super
  end

  # POST /admin/confirmation
  def create
    super
  end

  # GET /admin/confirmation?confirmation_token=abcdef
  def show
    super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
