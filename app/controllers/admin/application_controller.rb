class Admin::ApplicationController < ApplicationController
  before_filter :set_current_ability
  check_authorization

  def set_current_ability
    if @current_ability.nil? || @current_ability.class != AdminAbility
      @current_ability = AdminAbility.new(current_user)
    end
    @current_ability
  end
end
