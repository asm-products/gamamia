class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.sign_in_count == 1
         finish_signup_path(resource_or_scope)
      else
         games_path
      end
  end

  def user_is_admin?
    current_user && current_user.is_admin?
  end
  helper_method :user_is_admin?

  def check_admin
    unless user_is_admin?
      flash[:error] = "You do not have the permission for this site."
      redirect_to root_path
    end
  end
end
