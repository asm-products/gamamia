class Admin::ApplicationController < ApplicationController
  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
