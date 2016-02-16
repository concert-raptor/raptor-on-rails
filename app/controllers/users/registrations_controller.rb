class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :html,:js

  # before_filter :require_sign_in, :only => [:render_success_response]

  def new
    # build_resource({})
    # @description = "Sign up for Move Loot and get $25 off your first purchase! Move Loot is the easiest way to buy and sell used furniture. Ever."
    # rid = params[:rid] || session[:rid]
    # if rid
    #   session[:rid] = rid unless session[:rid]
    #   referrer = User.find_by_id( rid )
    #   if referrer.present?
    #     @referrer_name = referrer.first_name.present? ? referrer.first_name : referrer.email
    #   end
    # end
    # self.resource.email = params[:email]
    # respond_with self.resource
  end

  def create
    # add validations to user model
    # if !params[:user][:email].match(/\S+@\S+\.\S+/)
    #   flash[:error] = "That is not a valid email address."
    #   redirect_to new_user_registration_path(:next => params[:next]) and return
    # elsif provider = is_oauth_signup(params[:user][:email])  #for security, don't let users sign in via just email if they are already oauth
    #   flash[:warning] = "This email is already signed up via #{provider.titleize}."
    #   redirect_to new_user_registration_path(:next => params[:next])
    # elsif params[:user][:password].blank? || params[:user][:password_confirmation].blank?
    #   flash[:error] = "Please fill out the password & password confirmation fields."
    #   redirect_to new_user_registration_path(:next => params[:next]) and return
    # elsif  !(params[:user][:password] == params[:user][:password_confirmation])
    #   flash[:error] = "Your password and password confirmation do not match."
    #   redirect_to new_user_registration_path(:next => params[:next]) and return
    # else
    #   build_resource(sign_up_params)
    #   if create_or_merge_resource
    #     if resource.active_for_authentication?
    #       sign_up(resource_name, resource)
    #       render_success_response
    #     else
    #       render_inactive_response
    #     end
    #   else
    #     render_invalid_response
    #   end
    # end

  end


  #this method checks if their already exists a user account for this registration email
  #if the registration is a ghost or oauth registration it will complete the registration
  #otherwise it should return false and set the duplicate email error on the user instance
  def create_or_merge_resource
    # existing_account = User.unscoped.find_by(email: resource.email)
    # if existing_account.present? && (existing_account.ghost?)
    #   existing_account.assign_attributes(sign_up_params)
    #   self.resource = existing_account
    # end
    # self.resource.save
  end

  #Render out a successful signup response
  def render_success_response

    # set_flash_message :notice, :signed_up if is_navigational_format?
    # cookies[:new_user_created] = "source_general" #{:event_source => ""}
    # cookies.permanent[:has_signed_up] = "user_id_#{current_user.id}"

    # # subscription actions:
    # current_user.link_subscriptions
    # current_region = current_user.current_region || current_region || Region.find(Region.current_id)
    # if current_region.present?
    #   Subscription.mailing_list_subscribe(current_region.id, current_user.email)
    # end

    # # finished(:sign_up) #for split tests
    # if session["user_return_to"] == new_submission_path
    #   #continue to make new submission. Not sure if similar logic is needed for orders
    #   redirect_path = new_submission_path
    # else
    #   #prompt to select interests
    #   redirect_path = user_preferences_select_categories_path(new_user: true)
    # end
    # respond_to do |format|
    #   format.html{redirect_to redirect_path}
    #   format.js{render json: {success: true, errors: nil}}
    # end
  end

  #Render out an inactive user signup
  def render_inactive_response
    # expire_data_after_sign_in!
    # set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
    # respond_to do |format|
    #   format.html{ redirect_to after_inactive_sign_up_path_for(resource)}
    #   format.js{render json:{success: false, errors: ["User Account Inactive"]}}
    # end
  end

  #Render out an unsuccessful signup response
  def render_invalid_response
    # resource.valid?
    # respond_to do |format|
    #   format.html{render "devise/registrations/new"}
    #   format.js{render json:{success: false, errors: resource.errors.full_messages}}
    # end
  end

  def destroy
    # @user = User.find_by_id(params[:user_id]) || current_user
    # authorize! :manage, @user
    # @user.deactivate
    # sign_out @user

    # Subscription.mailing_list_unsubscribe_with_backup(@user.email)
    # redirect_to current_user_path, notice: "Your account has been deactivated. Please contact hello@moveloot to renew your account"
  end

  def is_oauth_signup(email)
    # existing_account = User.unscoped.find_by(:email => email)
    # if existing_account.present? && (existing_account.oauth_signup) && existing_account.encrypted_password.blank?
    #   return existing_account.identities.first.provider
    # end
  end

  private

  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation, :current_password)
  end

end
