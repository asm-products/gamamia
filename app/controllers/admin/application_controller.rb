class Admin::ApplicationController < ApplicationController
  before_filter :check_admin
end
