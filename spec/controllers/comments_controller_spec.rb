require 'rails_helper'

RSpec.describe CommentsController do
  let(:comment) { Fabricate :comment }
  let(:game) { Fabricate :game }

  let(:valid_params) { {game_id: game.id, comment: {content: "fake content"}} }

  describe "POST create" do
    context "with valid attributes" do
      before(:each) do
        @user = Fabricate(:user)
        sign_in(@user)
      end

      it "should save comment with subject" do
        expect {
          post :create, valid_params
        }.to change(Comment, :count).by(1)
      end

      it "should redirect to game path" do
        post :create, valid_params
        expect(response).to redirect_to(game_path(game))
      end

      it "should set user to current user" do
        post :create, valid_params
        expect(Comment.last.user).to eq(@user)
      end

      it "should set game" do
        post :create, valid_params
        expect(Comment.last.game).to eq(game)
      end

      it "should save parent" do
        parent_comment = Fabricate(:comment, game_id: game.id)
        post :create, {game_id: game.id, comment: {content: "fake content", parent_id: parent_comment.id}}
        child_comment = Comment.last
        expect(parent_comment.reload.children).to eq([child_comment])
        expect(child_comment.parent).to eq(parent_comment)
      end
    end

    context "with invalid attributes" do
      let(:invalid_params) { {game_id: game.id, comment: {content: ''}} }
      it "should render game" do
        @user = Fabricate(:user)
        sign_in(@user)

        expect {
          post :create, invalid_params
        }.to_not change(Comment, :count)

        expect(subject).to render_template('games/show')
      end

      it "should not create comment if not signed in" do
        expect {
          post :create, valid_params
        }.to_not change(Comment, :count)
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
