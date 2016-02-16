class Users::SessionsController < Devise::SessionsController
  def create
    if request.xhr?
      resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
      sign_in_and_redirect(resource_name, resource)
      @require_refresh_after_sign_in = params[:require_refresh_after_sign_in]
      respond_to do |format|
        format.js
      end
    else
      super
    end
    unless cookies[:has_signed_up]  #this is now set on create, but pre-existing users won't have it!
      cookies.permanent[:has_signed_up] = "user_id_#{current_user.id}"
    end
  end

  def destroy
    cookies[:analytics_id] = nil
    super
  end

  def sign_in_and_redirect(resource_or_scope, resource = nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
  end

  def failure
    # returns a JSON of the success being false and the errors from devise.
    # This will be picked up from the binding in login.js.coffee
    return render json: {
      success: false,
      errors: [t("devise.failure.invalid")]
    }
  end
end