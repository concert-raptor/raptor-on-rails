class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    if request.env["omniauth.auth"].andand.info[:email].present?
      response = user_from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
      user = response[:user]

      if (response[:action] == 'merge' ) || (response[:action] == 'login' )
        unless cookies[:has_signed_up]  #this is now set on create, but pre-existing users won't have it!
          cookies.permanent[:has_signed_up] = "user_id_#{user.id}"
        end
        flash.notice = "Signed in!"
        flash[:social_login_referral] = true
        sign_in_and_redirect user
      elsif  response[:action] == 'create'
        user.after_confirmation
        sign_in(user)
        # store_location_for(user, render_success_response_path)  # this sets up the right devise redirect, so we can use the devise sign_in method.  hacky
        flash[:social_login_referral] = true
        redirect_to  render_success_response_path and return
      end

    else
      flash[:error] = "Could not find the email address associated with this account."
      redirect_to :back
    end
  end
  alias_method :facebook, :all
  alias_method :paypal, :all
  alias_method :venmo, :all
  alias_method :"google_oauth2", :all

  private

  def user_from_omniauth(auth, params)
    identity = Identity.where(auth.slice(:uid, :provider).to_hash).first

    if identity.present?
      return {:user => identity.user, :action => 'login'}
    end

    #otherwise we need to create or merge an existing user account with this new identity
    raise "Omniauth auth params must include an email address in info hash" unless auth.info[:email]
    user = User.find_by(:email => auth.info[:email])
    if user.present?
      return {:user => merge_identities(user,auth), :action => 'merge'}
    else
      return {:user => create_new_user_and_identity(auth,params), :action => 'create'}


    end
  end

  #merges user information with newly added identity
  def merge_identities(user, auth)
    if auth.info[:first_name] && !user.first_name.present?
      user.first_name = auth.info[:first_name]
    end

    if auth.info[:last_name] && !user.last_name.present?
      user.last_name = auth.info[:last_name]
    end

    if auth.info[:email] && !user.email.present?
      user.email = auth.info[:email]
    end

    create_new_identity(user,auth)
  end

  # Creates a new user object and identity object given authorization parameters
  def create_new_user_and_identity(auth, params)
    user = User.create!(
        first_name: auth.info[:first_name],
        last_name: auth.info[:last_name],
        email: auth.info[:email],
        oauth_signup: true,
        # referred_by_user_id => params.andand["rid"]
    )
    user.confirm!
    create_new_identity(user, auth)
  end

  # Creates an identify for a particular user and provider
  def create_new_identity(user, auth)
    Identity.create! do |id|
      id.provider = auth['provider']
      id.uid = auth['uid']
      id.user = user
    end
    user
  end

end
