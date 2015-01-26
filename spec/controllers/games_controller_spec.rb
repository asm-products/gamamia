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
        get :show, {id: game}
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

  end

  context "not logged in" do

  end
end
