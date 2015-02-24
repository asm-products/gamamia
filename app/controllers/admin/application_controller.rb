class Admin::ApplicationController < ApplicationController
  before_filter :current_ability
  
  def current_ability
    if @current_ability.nil? || @current_ability.class != AdminAbility
      @current_ability = AdminAbility.new(current_user)
    end
    @current_ability
  end
end
