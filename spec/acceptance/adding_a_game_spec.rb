require 'rails_helper'

RSpec.feature "Adding a game", js: true do
  include_context "with user logged in"

  before do
    visit new_game_path
  end

  it 'adding a game' do
    expect(page).to have_content "Add a game"
  end
end
