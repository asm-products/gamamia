require 'rails_helper'

describe GamesController, type: :controller do
  let!(:game) { Fabricate :game }
  let(:game_params) { Fabricate.attributes_for(:game) }

  context "logged in as user" do
    before(:each) do
      @user = Fabricate(:user)
      sign_in(@user)
    end

    describe "GET index" do
      it "assigns all games as @games" do
        get :index
        expect(assigns(:games)).to eq([game])
      end
    end

    describe "POST create" do
      it "should not create game" do
        expect {
          post :create, game: game_params
        }.to change(Game, :count).by(0)
      end
    end

  end

  context "logged in as admin" do
    before(:each) do
      @user = Fabricate(:admin_user)
      sign_in(@user)
    end

    describe "POST create" do
      it "should create game" do
        expect {
          post :create, game: game_params
        }.to change(Game, :count).by(1)
      end
    end
  end

  context "not logged in" do

  end
end
