require 'rails_helper'

RSpec.describe Ability do
  let(:user) { Fabricate :user }
  let(:ability) {Ability.new(user)}

  context "games" do
    it "should read games index" do
      expect(ability.can? :index, Game).to be(true)
    end

    it "should not read unpublished game from other user" do
      pending
      game = Fabricate(:game, scheduled_at: nil)
      expect(ability.can? :show, game).to be(false)
    end

    it "should read unpublished game from user" do
      game = Fabricate(:game, scheduled_at: nil, user_id: user.id)
      expect(ability.can? :show, game).to be(true)
    end
  end

  context "users" do
    it "should finish signup" do
      expect(ability.can? :finish_signup, user).to be(true)
    end


    it "should show users" do
      expect(ability.can? :index, User).to be(true)
    end

    it "should show user" do
      expect(ability.can? :show, user).to be(true)
    end

    it "can edit himself" do
      expect(ability.can? :edit, user).to be(true)
      expect(ability.can? :update, user).to be(true)
    end

    it "cannot edit someone else" do
      expect(ability.cannot? :edit, Fabricate(:user)).to be(true)
      expect(ability.cannot? :update, Fabricate(:user)).to be(true)
    end
  end

end
