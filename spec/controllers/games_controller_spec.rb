require 'rails_helper'

RSpec.describe GamesController do
  let!(:game) { Fabricate :game }
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
        get :show, {id: game, layout: 'admin'}
        expect(response).to render_template(:show)
      end

    end

    describe "GET index" do
      subject { get :index }
      it "assigns all games as @games" do
        subject
        expect(assigns(:games)).to eq([game])
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
      it "should not create game" do
        expect {
          post :create, game: game_params
        }.to change(Game, :count).by(0)
      end
    end

    describe "DELETE destroy" do
      it "should not destroy game" do
        expect {
          delete :destroy, {id: game.to_param}
        }.to_not change(Game, :count)
      end

      it "redirects to the games list" do
        delete :destroy, {id: game.to_param}
        expect(response).to redirect_to(root_url)
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

    describe "GET show" do
      subject { get :show, {id: game, layout: 'admin'} }
      it "renders admin/index template for admins" do
        @user.update_attributes is_admin: true
        expect(subject).to render_template('games/admin/show')
      end
    end

    describe "GET index" do
      subject { get :index, layout: 'admin' }
      it "renders admin/index template for admins" do
        expect(subject).to render_template('games/admin/index')
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested game" do
        expect {
          delete :destroy, {id: game.to_param}
        }.to change(Game, :count).by(-1)
      end

      it "redirects to the games list" do
        delete :destroy, {id: game.to_param}
        expect(response).to redirect_to(games_url(layout: 'admin'))
      end
    end
  end

  context "not logged in" do

  end
end
