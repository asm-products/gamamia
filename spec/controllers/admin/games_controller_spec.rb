require 'rails_helper'

RSpec.describe Admin::GamesController do
  let!(:game) { Fabricate :game }
  let(:game_params) { Fabricate.attributes_for(:game) }

  context "admin user" do

    before(:each) do
      @user = Fabricate(:admin_user)
      sign_in(@user)
    end

    describe "PATCH update" do
      it "should save tags" do
        patch :update, {id: game.id, game: game_params.merge(platform_list: ["iOS", "Mac", "Windows"])}
        expect(game.reload.platform_list).to include("iOS")
        expect(game.reload.platform_list).to include("Mac")
        expect(game.reload.platform_list).to include("Windows")
      end

      it "should send notification email when scheduled" do
        game.update_attributes scheduled_at: nil
        expect {
          patch :update, {id: game.id, game: game_params.merge(scheduled_at: Date.today)}
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "should not send notification email when scheduled to admin users" do
        game.user = Fabricate(:admin_user)
        game.save
        expect {
          patch :update, {id: game.id, game: game_params.merge(scheduled_at: Date.today)}
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end

      it "should not send notification email when already scheduled" do
        game.update_attributes scheduled_at: Date.yesterday
        expect {
          patch :update, {id: game.id, game: game_params.merge(schedeuled_at: Date.today)}
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end

      it "should not send notification email not scheduled" do
        expect {
          patch :update, {id: game.id, game: game_params.merge(title: "test")}
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    describe "GET index" do
      subject { get :index, layout: 'admin' }
      it "renders admin/index template for admins" do
        expect(subject).to render_template('admin/games/index')
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested game" do
        expect {
          delete :destroy, {id: game.to_param}
        }.to change(Game, :count).by(-1)
      end

      it "only soft deletes the game" do
        expect {
          delete :destroy, {id: game.to_param}
          game.reload
        }.to change(game, :deleted_at).from(nil)
      end

      it "redirects to the games list" do
        delete :destroy, {id: game.to_param}
        expect(response).to redirect_to(admin_games_url)
      end
    end
  end

  context "logged in as user" do
    before(:each) do
      @user = Fabricate(:user)
      sign_in(@user)
    end

    it "should not access index" do
      get :index
      expect(response).to_not render_template(:index)
    end

    it "should not access index" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it "should not access edit" do
      get :edit, id: game.id
      expect(response).to_not render_template(:edit)
    end

    it "should not access update" do
      patch :update, {id: game.id, game: game_params.merge(schedeuled_at: Date.today)}
      expect(response).to redirect_to(root_url)
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
end
