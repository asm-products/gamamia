require 'rails_helper'

RSpec.describe VideosController do
  let(:game) { Fabricate :game }

  context "admin user" do
    before(:each) do
      @user = Fabricate(:admin_user)
      sign_in(@user)
    end

    describe "POST create" do
      subject {post :create, { game_id: game.to_param, video: Fabricate.attributes_for(:video) }}
      it "should redirect to game" do
        expect(subject).to redirect_to(game_path(game))
      end

      it "should create video for game" do
        old_count = game.videos.count
        subject
        expect(game.videos.count).to eq(old_count + 1)
      end

      it "should render game/show if video is not saved" do
        game
        expect_any_instance_of(Video).to receive(:save).and_return(false)
        expect(subject).to render_template('games/show')
      end
    end
  end

  context "user" do
    before(:each) do
      @user = Fabricate(:user)
      sign_in(@user)
    end

    describe "POST create" do
      subject {post :create, { game_id: game.to_param, video: Fabricate.attributes_for(:video) }}
      it "should redirect to root" do
        expect(subject).to redirect_to(root_path)
      end

      it "should create video for game" do
        old_count = game.videos.count
        subject
        expect(game.videos.count).to eq(old_count)
      end
    end
  end
end
