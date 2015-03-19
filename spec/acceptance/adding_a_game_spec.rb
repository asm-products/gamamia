require 'rails_helper'

RSpec.feature "Adding a game" do
  include_context "with user logged in"

  before do
    visit new_game_path
  end

  def add_game
    fill_in :game_title, with: "Test Game"
    fill_in :game_link, with: "testgame.com"
    click_on 'Submit Game'
  end

  it 'shows the form to add a new game' do
    expect(page).to have_content "Add a game"
  end

  it 'adds a game for review' do
    add_game
    expect(page).to have_content "Thanks for submitting, your submission is under review"
  end

  it 'should show reviewing game' do
    add_game
    visit game_path(Game.last)

    expect(page).to have_content "This game is under review."
    expect(page).to have_content "Test Game"
    expect(page).to have_content "testgame.com"
  end

end
