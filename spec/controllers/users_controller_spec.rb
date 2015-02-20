require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { Fabricate :user }
  describe "GET finish_signup" do
    it "should redirect to root if no user is signed up" do
      get :finish_signup, id: user.id
      expect(response).to redirect_to(root_path)
    end
  end
end
