require 'rails_helper'

RSpec.describe Ability do

  context "user" do
    let(:user) { Fabricate :user }
    let(:ability) {Ability.new(user)}

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

end
