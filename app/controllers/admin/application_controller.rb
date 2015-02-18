class Admin::ApplicationController < ApplicationController
  def current_ability
    if @current_ability.nil? || @current_ability.class != AdminAbility
      @current_ability || AdminAbility.new(current_user)
    end
  end
end
