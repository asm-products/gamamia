require 'rails_helper'

RSpec.describe Platform, type: :model do
  it { should have_many(:game_platforms) }
  it { should have_many(:games) }
end
