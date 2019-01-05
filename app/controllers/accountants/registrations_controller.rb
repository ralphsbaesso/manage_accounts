# frozen_string_literal: true

class Accountants::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @accountant = Accountant.new
  end

  # POST /resource
  def create


    @transporter = Transporter.new

    if params[:family_name].present?
      @family_name = params[:family_name]
      family = Family.new(name: @family_name)
    else
      @transporter.messages << 'Deve criar uma família'
      @transporter.status = 'RED'
      @accountant = Accountant.new(accountant_params)
      render :new
      return
    end

    super do

      if resource.errors.present?
        @accountant.errors.full_messages.each do |erro|
          @transporter.messages << erro
        end
        @transporter.status = 'RED'
        @accountant = Accountant.new(accountant_params)
        render :new
        return
      else
        @accountant = resource
      end
    end

    family.accountants << @accountant
    family.save
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, family: [:family_id]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #
  private

  def accountant_params
    params.require(:accountant).permit(:name, :email, :password, :password_confirmation)
  end
end
