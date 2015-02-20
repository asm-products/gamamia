class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    session[:referrer_url] = request.referrer
    flash[:error] = if current_user
      exception.message
    else
      "You need to be signed in for that action. Please click Login above to sign in or register."
    end
    flash.keep(:error)
    render js: "window.location = '#{back_or_root_path}'"
  end

  def user_is_admin?
    current_user && current_user.is_admin?
  end
  helper_method :user_is_admin?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.sign_in_count == 1
      finish_signup_path(resource_or_scope)
    else
      session[:referrer_url] || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
  end

  def back_or_root_path
    session[:referrer_url] || root_path
  end
end
