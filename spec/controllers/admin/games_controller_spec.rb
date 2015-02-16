require 'rails_helper'

RSpec.describe Admin::GamesController do
  let!(:game) { Fabricate :game }
  let(:game_params) { Fabricate.attributes_for(:game) }

  before(:each) do
    @user = Fabricate(:admin_user)
    sign_in(@user)
  end

  describe "PATCH update" do
    it "should save tags" do
      patch :update, {id: game.id, game: game_params.merge(platform_list: ["iOS", "Mac", "Windows"])}
      expect(game.reload.platform_list).to eq(["iOS", "Mac", "Windows"])
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

  context "logged in as user" do
    before do
      @user.update_attributes is_admin: false
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
