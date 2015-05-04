require 'rails_helper'

RSpec.describe Admin::GameDevelopersController do
  let(:developer) { Fabricate.create(:game_developer) }
  let(:developer_params) { Fabricate.attributes_for(:game_developer) }

  before(:each) do
    @user = Fabricate(:admin_user)
    sign_in(@user)
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the record to the database" do
        expect {
          post :create, game_developer: developer_params
        }.to change(GameDeveloper, :count).by(1)
      end

      it "redirects to game_developers#show" do
        post :create, game_developer: developer_params
        expect(response).to redirect_to(admin_game_developers_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the record" do
        expect {
          post :create, game_developer: developer_params.merge(title: nil)
        }.to_not change(GameDeveloper, :count)
      end

      it "should re-render the new template" do
        post :create, game_developer: developer_params.merge(title: nil)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    before do
      @dev = Fabricate(:game_developer)
    end

    context "with valid attributes" do
      it "finds the record" do
        patch :update, id: @dev, game_developer: Fabricate.attributes_for(:game_developer, title: 'new title')
        expect(assigns(:game_developer)).to eq @dev
      end

      it "updates the attributes" do
        patch :update, id: @dev, game_developer: Fabricate.attributes_for(:game_developer, title: 'new title')
        @dev.reload
        expect(@dev.title).to eq 'new title'
      end

      it "redirects to game_developers#show" do
        patch :update, id: @dev, game_developer: developer_params
        expect(response).to redirect_to(admin_game_developers_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the attributes" do
        patch :update, id: @dev, game_developer: Fabricate.attributes_for(:game_developer, title: nil)
        expect(@dev.title).to_not eq 'new title'
      end

      it "should re-render the edit template" do
        patch :update, id: @dev, game_developer: Fabricate.attributes_for(:game_developer, title: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#edit" do
    it "assigns the requested developer" do
      get :edit, id: developer
      expect(assigns(:game_developer)).to eq developer
    end

    it "renders the :edit template" do
      get :edit, id: developer
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @dev = Fabricate(:game_developer)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @dev
      }.to change(GameDeveloper, :count).by(-1)
    end

    it "redirects to game_developers#index" do
      delete :destroy, id: @dev
      expect(response).to redirect_to admin_game_developers_path
    end
  end
end
