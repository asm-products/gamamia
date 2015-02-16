class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    #authorize! :update, @user
    @user.email = nil if !@user.email_verified?
    if request.patch? && params[:user]
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        flash[:notice] = ""
        redirect_to root_url
      else
        # If user already exist with that e-mail tell the user that
        # TODO Improve this flow. What should actually happen when the following happens:
        # 1. The user signs-up with Twitter, goes about his business and signs-out
        # 2. Later returns to our site but this time clicks sign-in with Facebook. He will then not be recognized
        #    hence flashed the usual sign-up procedure.
        # 3. If he then enters the e-mail he used to sign-up with in step 1, what should actually happen?
        if User.find_by_email(user_params[:email])
          flash[:notice] = "A user already exist with that e-mail."
        end
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = current_user
    end

    # This checks which parameters are permitted for change. Remember to update it if new parameters are introduced
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation,:occupation, :receive_newsletter)
    end
end
