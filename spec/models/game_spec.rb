require 'rails_helper'

RSpec.describe Game do
  let(:game) { Fabricate :game }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:link) }

  it { should have_many(:game_platforms) }
  it { should have_many(:platforms) }
  it { should belong_to(:game_developer) }

  before(:each) do
    ios = Platform.create!(name: "iOS")
    mac = Platform.create!(name: "Mac")

    @ios_game1 = Fabricate(:game)
    @ios_game1.platforms << ios

    @ios_game2 = Fabricate(:game)
    @ios_game2.platforms << ios

    @mac_game = Fabricate(:game)
    @mac_game.platforms << mac
  end

  it "should retrieve with platform" do
    expect(Game.with_platform("Mac")).to eq([@mac_game])
  end

  it "should retrieve related platform games" do

    expect(@ios_game1.find_related_platforms).to eq([@ios_game2])
  end
end
