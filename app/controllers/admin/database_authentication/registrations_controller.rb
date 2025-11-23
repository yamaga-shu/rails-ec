# frozen_string_literal: true

class Admin::DatabaseAuthentication::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /admin/sign_up
  def new
    super
  end

  # POST /admin
  def create
    default_create
  end

  # GET /admin/edit
  def edit
    super
  end

  # PUT /admin
  def update
    super
  end

  # DELETE /admin
  def destroy
    ActiveRecord::Base.transaction do
      # 関連するAdminを取得
      admin = resource.admin

      # Adminを削除
      # model 定義により、関連する
      # - Admin::DatabaseAuthentication
      # - Admin::Registration
      # も削除される
      admin.destroy! if admin

      yield resource if block_given?

      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message! :notice, :destroyed
      respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
    end
  rescue ActiveRecord::RecordNotDestroyed => e
    # トランザクション内でエラーが発生した場合の処理
    flash[:alert] = "Account deletion failed: #{e.message}"
    redirect_to edit_admin_database_authentication_registration_path
  end

  # GET /admin/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  # Creates Admin and Admin::DatabaseAuthentication in transaction
  #
  # Handles the registration flow for admin users by first creating
  # an Admin record, then associating it with Admin::DatabaseAuthentication.
  # This ensures data consistency in our separated model structure.
  #
  # @return [void]
  # @raise [ActiveRecord::RecordInvalid] if validation fails on either model
  # @see Devise::RegistrationsController#create
  def default_create
    build_resource(sign_up_params)

    ActiveRecord::Base.transaction do
      # まずAdminを作成
      admin = Admin.create!

      # Admin::DatabaseAuthenticationにadmin_idを設定
      resource.admin = admin

      # Admin::DatabaseAuthenticationを保存
      resource.save!

      # 拡張の提供
      # 例) メール送信、ログなど
      yield resource if block_given?

      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    # トランザクション内でエラーが発生した場合の処理
    flash.now[:alert] = "Registration failed: #{e.message}"
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end
end
