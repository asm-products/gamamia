require 'rails_helper'

RSpec.describe GamesController do
  let!(:game) { Fabricate :game, scheduled_at: Date.yesterday }
  let(:game_params) { Fabricate.attributes_for(:game) }

  context "logged in as user" do
    before(:each) do
      @user = Fabricate(:user)
      sign_in(@user)
    end

    describe "GET show" do
      subject { get :show, {id: game} }

      it "renders show template" do
        expect(subject).to render_template(:show)
      end

      it "assigns game to @game" do
        subject
        expect(assigns(:game)).to eq(game)
      end

      it "renders index template for users when trying to access admin template" do
        get :show, {id: game}
        expect(response).to render_template(:show)
      end

    end

    describe "GET index" do
      subject { get :index }
      it "assigns scheduled games as @days" do
        subject
        day = game.scheduled_at.to_date
        expect(assigns(:days)).to eq({day => [game]})
      end

      it "renders index template" do
        expect(subject).to render_template(:index)
      end

      it "renders index template for users when trying to access admin template" do
        get :index, layout: 'admin'
        expect(response).to render_template(:index)
      end
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
