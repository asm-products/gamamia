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
      it "assigns scheduled games as @weeks" do
        subject
        week = game.scheduled_at.beginning_of_week
        expect(assigns(:weeks)).to eq([[week,[game]]])
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

      it "should save tags" do
        post :create, game: game_params.merge(platform_list: ["iOS", "Mac", "Windows"])
        expect(Game.last.platform_list).to eq(["iOS", "Mac", "Windows"])
      end

    end

  end

  context "not logged in" do
    describe "POST create" do
      it "should redirect to root" do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST unupvote" do
      it "should redirect to root" do
        post :unupvote, id: game.id
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST upvote" do
      it "should redirect to root" do
        post :upvote, id: game.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
