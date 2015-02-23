require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { Fabricate :user }
  describe "GET finish_signup" do
    it "should redirect to root if no user is signed up" do
      get :finish_signup, id: user.to_param
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET show" do
    it "should assign user" do
      get :show, id: user.to_param
      expect(assigns(:user)).to eq(user)
    end

    it "should render show template" do
      get :show, id: user.to_param
      expect(request).to render_template(:show)
    end
  end

  context "logged in" do
    before(:each) do
      sign_in(user)
    end

    describe "GET edit" do
      it "should assign user" do
        get :edit, id: user.to_param
        expect(assigns(:user)).to eq(user)
      end

      it "should render edit template" do
        get :edit, id: user.to_param
        expect(request).to render_template(:edit)
      end
    end

    describe "PATCH update" do
      let(:user_attributes) { Fabricate.attributes_for(:user) }
      subject { patch :update, id: user.to_param, user: user_attributes}
      it "should update user" do
        subject
        expect(user.reload.attributes).to include(user_attributes.slice!(:password, :password_confirmation))
      end

      it "should redirect to user page" do
        subject
        expect(response).to redirect_to(user.reload)
      end
    end
  end
end
